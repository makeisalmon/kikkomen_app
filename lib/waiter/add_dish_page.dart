import 'package:flutter/material.dart';
import 'package:kikkomen_app/components/numberPicker.dart';
import 'package:kikkomen_app/server_service.dart';
import 'package:kikkomen_app/waiter/waiter_page.dart';
import 'package:mysql1/mysql1.dart';

class AddDishPage extends StatefulWidget {
  static ValueNotifier<String> selectedDish = ValueNotifier<String>("");
  final int tableNum;
  final String empId;
  AddDishPage({
    super.key,
    required this.tableNum,
    required this.empId,
  });

  @override
  State<AddDishPage> createState() => _AddDishPageState();
}

class _AddDishPageState extends State<AddDishPage> {
  int quantity = 1;

  String description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Dish to Table ${widget.tableNum}"),
      ),
      body: Row(
        children: [
          Flexible(
            flex:1,
            child: Container(
              child: DishNameList()
            )
          ),
          Divider(),
          Flexible(
            flex:2,
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  ValueListenableBuilder(
                    valueListenable: AddDishPage.selectedDish,
                    builder: (context, value, child) {
                      return Text(
                        value.isEmpty? "Select a Dish" : value,
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    },
                  ),
                            Padding(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
                    child: TextField(
                      onChanged: (newValue){description = newValue;},
                      maxLines: 6,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        hintText: 'Additional Instructions (optional)',
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Quantity:  ",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        NumberPicker(
                          initialValue: 1,
                          onChanged: (newValue){quantity = newValue;},
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height:48),
                  FilledButton(
                    onPressed: () async {
                      
                      print("Composing query...\n");
                      List<String> query = [
                        """SELECT (MAX(order_num) + 1) INTO @order_num FROM cus_order;""",
                        """INSERT INTO cus_order (order_num, table_num, emp_id, status, date, order_total, tip) 
                            VALUES (@order_num, ${widget.tableNum}, "${widget.empId}", 'OPEN', NOW(), 0.00, 0.00);""",
                        """INSERT INTO ticket (order_num, dish_name, description, quantity)
                          VALUES (@order_num, "${AddDishPage.selectedDish.value}", "$description", $quantity);""",
                        """UPDATE res_table SET status = "OCCUPIED" WHERE table_num = ${widget.tableNum};""" 
                      ];
                      print(query);
                      await ServerService.serverConnection.transaction((conn) async {
                        for (String statement in query) {
                          print(statement);
                          print("\n");
                          await ServerService.serverConnection.query(statement);
                        }
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WaiterPage(
                            empId: widget.empId,
                          ),
                        ),
                      );
                    },
                    child: const Text("Add to Ticket",),
                  )
                ],
              )
            )
          )
        ],
      )
    );
  }
}

// class SelectedDishHeader extends StatefulWidget {
//   const SelectedDishHeader({
//     super.key,
//   });
//   @override
//   State<StatefulWidget> createState() => _SelectedDishHeaderState();
// }
// class _SelectedDishHeaderState extends State<SelectedDishHeader> {
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       SelectedDishHeader.,
//       style: Theme.of(context).textTheme.headlineMedium,
//     );
//   }
// }

class DishNameList extends StatefulWidget {
  const DishNameList({
    super.key,
  });
  
  @override createState() => _DishNameListState();

}
class _DishNameListState extends State<DishNameList> {

  late final Future<Results> dishNames;

  void waitForQuery() async {
    dishNames = ServerService.serverConnection.query('SELECT * FROM dish');
  }
  @override
  void initState() {
    super.initState();
    waitForQuery();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dishNames,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No dishes found.'),
          );
        }

        final dishes = snapshot.data!;
        return ListView(

          children: dishes.map((row) {
            final dishName = row['dish_name'].toString(); // Assuming your query has a 'name' column
            return ListTile(
              onTap: (){
                setState(() {
                  AddDishPage.selectedDish.value = dishName;
                });
              },
              title: Text(
                dishName,
              ),
              tileColor: Theme.of(context).colorScheme.onPrimary,
              selected: AddDishPage.selectedDish.value == dishName,
            );
          }).toList(),
        );
      }
    );
  }
}