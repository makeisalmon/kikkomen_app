import 'package:flutter/material.dart';
import 'package:kikkomen_app/host_page.dart';
import 'package:kikkomen_app/server_service.dart';
import 'package:kikkomen_app/waiter/add_dish_page.dart';
import 'package:kikkomen_app/waiter/waiter_page.dart';

void main() {
  ServerService.establishConnection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: const WaiterPage(),
      initialRoute: '/WaiterPage',
      routes: {
        '/WaiterPage': (context) => const WaiterPage(),
        '/HostPage': (context) => const HostPage(),
        '/AddDishPage': (context) => AddDishPage(),
      }, 
    );
  }
}
