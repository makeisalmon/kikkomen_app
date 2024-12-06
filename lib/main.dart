import 'package:flutter/material.dart';
import 'package:kikkomen_app/host_page.dart';
import 'package:kikkomen_app/server_service.dart';
import 'package:kikkomen_app/waiter/add_dish_page.dart';
import 'package:kikkomen_app/waiter/waiter_page.dart';

void main() {
  runApp(const MainApp());
  testQuery();
}

Future<void> testQuery() async {
  await ServerService.establishConnection();
  //print(result);
  // for (var row in result) {
  //   Map map = row.fields;
  //   //print(map.toString() + "\n\n");
  //   map.forEach((key, value) {
  //     print(key.toString() + ", " + key.runtimeType.toString());
  //     print(value.toString() + ", " + value.runtimeType.toString() + "\n");
  //   });
  //   print("there should be 7 of these!");
  //   //print(row.toString());
  // }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ServerService.establishConnection(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          /* real quick loading screen so the app doesn't flashbang you with a black screen */
          return Container(color: Color(0xFFfef7ff), width: 250, height: 250,child: CircularProgressIndicator());
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          //home: const WaiterPage(),
          initialRoute: '/HostPage',
          routes: {
            '/WaiterPage': (context) => const WaiterPage(),
            '/HostPage': (context) => const HostPage(),
          }, 
        );
      }
    );
  }
}
