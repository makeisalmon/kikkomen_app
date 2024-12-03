import 'package:flutter/material.dart';
import 'package:kikkomen_app/navbar.dart';

class HostPage extends StatelessWidget {
  const HostPage({super.key}); // TODO: Why do public widget constructors require a key parameter?


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const NavBar(),
      body: const Center(
        child: Text("Host Page(unfinished)"),
      )
    );
  }
}