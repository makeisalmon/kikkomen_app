import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text("User Interface")
          ),
          ListTile(
            title: const Text("Waiter"),
            onTap:(){Navigator.pushNamed(context, "/WaiterPage");},
            selected: false,
          ),
          ListTile(
            title: const Text("Host"),
            onTap:(){Navigator.pushNamed(context, "/HostPage");},
            selected: false,
          )
        ]
      )
    );
  }
}