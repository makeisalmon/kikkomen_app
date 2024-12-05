import 'package:flutter/material.dart';
import 'package:kikkomen_app/server_service.dart';
import 'package:mysql1/mysql1.dart';

class AssignWaiterDialog extends StatelessWidget {
  final int tableNum;
  final VoidCallback onRefresh;

  const AssignWaiterDialog({
    Key? key,
    required this.tableNum,
    required this.onRefresh,
  }) : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchEmployeeData() async {
    final Results result = await ServerService.serverConnection.query(
      """
      SELECT DISTINCT emp_id, first_name, last_name, cur_pos, status 
      FROM employee 
      NATURAL JOIN emp_shift 
      WHERE cur_pos = 'Server';
      """
    );

    List<Map<String, dynamic>> employees = [];
    for (var row in result) {
      employees.add(row.fields);
    }
    return employees;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchEmployeeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return SizedBox(
              height: 200,
              child: Center(child: Text('Error: ${snapshot.error}')),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const SizedBox(
              height: 200,
              child: Center(child: Text('No employees available')),
            );
          }

          final employees = snapshot.data!;
          return ListView(
            shrinkWrap: true,
            children: employees.map((employee) {
              final empId = employee['emp_id'];
              final firstName = employee['first_name'];
              final lastName = employee['last_name'];
              final status = employee['status'];

              return ListTile(
                title: Text('$firstName $lastName ($empId)'),
                subtitle: status == 'Off Shift' ? const Text('Off Shift') : null,
                enabled: status == 'On Shift',
                onTap: status == 'On Shift'
                    ? () async {
                      await ServerService.serverConnection.transaction((conn) async {;
                        await ServerService.serverConnection.query(
                            """
                            SELECT (MAX(order_num) + 1) INTO @order_num FROM cus_order;
                            """
                          );
                          await ServerService.serverConnection.query(
                            """
                            INSERT INTO cus_order (order_num, table_num, emp_id, status, date, order_total, tip) 
                            VALUES (@order_num, $tableNum, '$empId', 'OPEN', NOW(), 0.00, 0.00);
                            """
                          );
                          await ServerService.serverConnection.query(
                            """
                            UPDATE res_table
                            SET status = 'OCCUPIED'
                            WHERE table_num = $tableNum;
                            """
                          );
                       }
                      );
                        onRefresh();
                        Navigator.pop(context);
                      }
                    : null,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}