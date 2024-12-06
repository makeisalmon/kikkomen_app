import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kikkomen_app/navbar.dart';
import 'package:kikkomen_app/server_service.dart';
import 'package:kikkomen_app/waiter/selectEmployee.dart';
import 'package:mysql1/mysql1.dart';
import 'package:kikkomen_app/waiter/ticket_card.dart';

class WaiterPage extends StatefulWidget {
  static bool isPending = false;
  final String empId;
  const WaiterPage({super.key, this.empId = "E001"});
  @override
  _WaiterPageState createState() => _WaiterPageState();
}

class _WaiterPageState extends State<WaiterPage> {
  late Future<String> empName;
  late Future<List<Map<String, dynamic>>> tableData;

  @override
  void initState() {
    super.initState();
    empName = fetchEmpName(widget.empId);
    tableData = fetchTables();
  }
  
  Future<String> fetchEmpName(String empId) async {
    Results result = await ServerService.serverConnection
        .query('SELECT first_name, last_name FROM employee WHERE emp_id = ?', [empId]);
    if (result.isNotEmpty) {
      return "${result.first['first_name']} ${result.first['last_name']}";
    } else {
      return "Unknown";
    }
  }

  Future<List<Map<String, dynamic>>> fetchTables() async {
    print(widget.empId);
    Results result = await ServerService.serverConnection.query(
      """
      select distinct cus_order.table_num, res_table.status, cus_order.emp_id
      from cus_order, res_table
      where cus_order.status != "CLOSED" and cus_order.table_num = res_table.table_num
      AND cus_order.emp_id = '${widget.empId}';
      """
    );
    List<Map<String, dynamic>> serverTables = [];
    for (var row in result) {
      final fields = row.fields;
      int? tableNum = fields['table_num'];
      String status = fields['status'];
      if (status != 'CLOSED') {
        serverTables.add({'table_num': tableNum
        });
        int table_num = row.fields['table_num'];
        print("${row.fields['table_num']} is occupied!");
        print(row.fields);
      }
    }
    return serverTables;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Waiter 2: Special Edition"),
      ),
      drawer: const NavBar(),
      floatingActionButton: FutureBuilder<String>(
        future: empName,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Loading..."),
            );
          } else if (snapshot.hasError) {
            return FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Error loading employee"),
            );
          } else {
            return FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SelectServerDialog();  // Show the SelectServerDialog
                  },
                );
              },
              label: Text(
                "Working As: ${snapshot.data!} (${widget.empId})\nCLICK TO CHANGE",
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: tableData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Not assigned to any tables."));
          } else {
            // Build a list of TicketCards for each table
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final table = snapshot.data![index];
                return TicketCard(
                  tableNum: table['table_num'],
                  //orderNum: table['order_num'],
                  empId: widget.empId,
                );
              },
            );
          }
        },
      ),
    );
  }
}
