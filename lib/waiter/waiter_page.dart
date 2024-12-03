import 'package:flutter/material.dart';
import 'package:kikkomen_app/navbar.dart';
import 'package:kikkomen_app/waiter/ticket_card.dart';

class WaiterPage extends StatelessWidget {
  const WaiterPage({super.key}); // TODO: Why do public widget constructors require a key parameter?


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("the waiter 2: special edition"),
      ),
      drawer: const NavBar(),
      body: TicketCard(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){}, 
        label: Text("New Order")
      ),
    );
  }
}