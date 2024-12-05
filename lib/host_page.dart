//TODO: DISALLOW REMOVING PENDING ORDERS
import 'package:flutter/material.dart';
import 'package:kikkomen_app/navbar.dart';
import 'package:kikkomen_app/server_service.dart';
import 'package:kikkomen_app/waiter/assign_waiter_dialog.dart';
import 'package:mysql1/mysql1.dart';

class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  late Future<List<Map<String, dynamic>>> _tableData;

  @override
  void initState() {
    super.initState();
    _tableData = _fetchTableData();
  }

  Future<List<Map<String, dynamic>>> _fetchTableData() async {
    final Results result = await ServerService.serverConnection.query(
      """
      SELECT res_table.table_num, res_table.status, COUNT(cus_order.order_num) AS order_count
      FROM res_table
      LEFT JOIN cus_order ON res_table.table_num = cus_order.table_num AND cus_order.status = 'OPEN'
      GROUP BY res_table.table_num;
      """
    );

    List<Map<String, dynamic>> tableData = [];
    for (var row in result) {
      tableData.add(row.fields);
    }
    return tableData;
  }

  Color _getTableColor(String status) {
    switch (status) {
      case 'OPEN':
        return Colors.green;
      case 'OCCUPIED':
        return Colors.red;
      case 'NEED CLEANING':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  void _openAssignWaiterDialog(int tableNum) async {
    showDialog(
      context: context,
      builder: (context) => AssignWaiterDialog(
        tableNum: tableNum,
        onRefresh: () {
          setState(() {
            _tableData = _fetchTableData();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Host 1.0"),
      ),
      drawer: const NavBar(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _tableData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          final tableData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: tableData.map((table) {
                final tableNum = table['table_num'];
                final String status = table['status'].toUpperCase();
                final orderCount = table['order_count'];
                final color = _getTableColor(status);

                return GestureDetector(
                  onTap: status == 'OPEN'
                      ? () => _openAssignWaiterDialog(tableNum)
                      : status == "NEED CLEANING" ? () =>_cleanTable(tableNum) : null,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Text(
                            'Table $tableNum',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            status,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if (orderCount == 1)
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: IconButton(
                              icon: const Icon(Icons.undo, color: Colors.black),
                              onPressed: () async {
                                // TODO: Wrap in Transaction
                                await ServerService.serverConnection.query(
                                  """
                                  DELETE FROM cus_order 
                                  WHERE table_num = $tableNum AND status = 'OPEN';
                                  """
                                );
                                await ServerService.serverConnection.query(
                                  """
                                  UPDATE res_table SET status = 'OPEN' WHERE table_num = $tableNum;
                                  """
                                );
                                setState(() {
                                  _tableData = _fetchTableData();
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
  
  _cleanTable(tableNum) async {
    ServerService.serverConnection.query(
      'UPDATE res_table SET status = "OPEN" WHERE table_num = $tableNum'
    );
    setState(() {
      _tableData = _fetchTableData();
    });
  }
}
