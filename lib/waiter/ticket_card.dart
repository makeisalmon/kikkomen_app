import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kikkomen_app/server_service.dart';
import 'package:kikkomen_app/waiter/add_dish_page.dart';
import 'package:kikkomen_app/waiter/waiter_page.dart';
import 'package:mysql1/mysql1.dart';

/* Currently a static widget. TODO: load proper data into widget upon construction. */
class TicketCard extends StatefulWidget {
  final int tableNum;
  //final int orderNum;
  final String empId;

  TicketCard({
    super.key,
    //required this.orderNum,
    required this.tableNum, 
    required this.empId,
  });

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  late Future<List<Map>> _orderInfo;

  @override
  void initState() {
    super.initState();
    _orderInfo = _fetchOrderInfo();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _orderInfo,
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        print(snapshot.data);
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                width: 256,
                child: Card.outlined(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16,12,16,0),
                        child: Text(
                          "Table ${widget.tableNum}",
                          style: Theme.of(context).textTheme.headlineSmall
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16,0,0,12),
                        child: Text(
                          "STATUS: ${snapshot.data!.isNotEmpty ? snapshot.data!.first['status'] : "NO ORDERS"}",
                          style: Theme.of(context).textTheme.bodyMedium
                        ),
                      ),
                      const Divider(height:0,),
                      for (var row in snapshot.data!)
                      if (snapshot.data!.isNotEmpty) Dish (
                        dishName: row['dish_name'], 
                        quantity: row['quantity'], 
                        description: row['description'],
                        orderNum: row['order_num'],
                        onDelete: (){
                          setState(() {
                              // After the delete operation, refetch the data to reflect the changes
                              _orderInfo = _fetchOrderInfo();
                            });},
                      ),
                      const Divider(height:0,),
                      const SizedBox(height:12),
                      Row(
                        children: [
                          const SizedBox.square(dimension: 16),
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddDishPage(tableNum: widget.tableNum, empId: widget.empId),
                                  ),
                                );
                              }, //TODO
                              child: const Text("Add Dish"),
                            ),
                          ),
                          const SizedBox.square(dimension: 16),
                          FilledButton(
                            onPressed: processPayment,
  
                            child: const Icon(Icons.payment),
                          ),
                          const SizedBox.square(dimension: 16),
                        ],
                      ),
                      const SizedBox(height:12),
                    ],
                  ),
                )
              ),
            ],
          ),
        );
      }
    );
  }

  void processPayment() async {
      int tableNum = widget.tableNum; // Assuming `widget.tableNum` is available
      if (WaiterPage.isPending = false) {
        return;
      }
      WaiterPage.isPending = true;
      // First query: Mark the order as 'PENDING'
      await ServerService.serverConnection.query(
        "UPDATE cus_order SET status = 'PENDING' WHERE table_num = $tableNum AND status = 'OPEN';"
      );
  
      // Rebuild the TicketCard after the first query
      setState(() {
        _orderInfo = _fetchOrderInfo();
      });
  
      // Wait between 4 to 8 seconds
      await Future.delayed(Duration(milliseconds: 250 + (Random().nextInt(750))));
  
      // Second queries: Update the table and close the order
      await ServerService.serverConnection.query(
        """
        UPDATE res_table SET status = 'NEED CLEANING' WHERE table_num = $tableNum;
        """
      );
      await ServerService.serverConnection.query(
        """
        UPDATE cus_order SET status = 'CLOSED' WHERE table_num = $tableNum AND status = 'PENDING';
        """
      );
      WaiterPage.isPending = false;
  
      // Rebuild the TicketCard after the second query
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WaiterPage(empId: widget.empId),
          ),
        );
      });
    }

  Future<List<Map<String, dynamic>>> _fetchOrderInfo() async {
    final orderQuery = await ServerService.serverConnection.query('Select * from ticket natural join cus_order where table_num = ${widget.tableNum} AND status != "CLOSED"');
    /* get a List of row data in the form of a Map of attribute names and values */
    List<Map<String, dynamic>> toAdd = [];
    for (var row in orderQuery) {
      toAdd.add(row.fields);
    }
    return toAdd;
  }
}

class Dish extends StatelessWidget {
  final String dishName;
  final int quantity;
  final String description;
  final int orderNum;
  final void Function()? onDelete;

  const Dish({
    super.key,
    required this.dishName,
    required this.quantity,
    required this.description,
    required this.orderNum,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("$quantity $dishName"),
        subtitle: description.isEmpty? null : Text(description),
        trailing: IconButton(
          onPressed: () async {
            //TODO: There are still some ticket items with duplicate order_nums.
            ServerService.serverConnection.query(
            "DELETE from cus_order where order_num = $orderNum;"
            );
            if (onDelete != null) {
              onDelete!();
            }
          },
          icon: const Icon(Icons.remove_circle)
        ),
      ),
    );
    /*return Expanded(
      child: Container(
        color: Theme.of(C)
        child: const Padding(
          padding: const EdgeInsets.fromLTRB(16,8,16,8),
          child: Text("PLEASE"),
        ),
      )
    );*/
  }
}