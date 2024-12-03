import 'package:flutter/material.dart';

class AddDishPage extends StatelessWidget {
  const AddDishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Dish to Table 41"),
      ),
      body: Row(
        children: [
          Flexible(
            flex:1,
            child: Container(
              // decoration: BoxDecoration(
              //   color: Theme.of(context).colorScheme.onPrimary,
              //   boxShadow: const [BoxShadow(
              //     blurRadius: 20,
              //     spreadRadius: -16
              //   )]
              // ),
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Beans with Extra Fork",),
                    selected: false,
                    tileColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  ListTile(
                    title: Text("Sweet Tuna Roll",),
                    selected: true,
                    tileColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  ListTile(
                    title: Text("SOFT DRINK",),
                    selected: false,
                    tileColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ],
              )
            )
          ),
          Divider(),
          Flexible(
            flex:2,
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              // decoration: const BoxDecoration(
              //   boxShadow: [
              //     BoxShadow()
              // ),
              child: Column(
                children: [
                  SizedBox(height: 32),
                  Text(
                    "Sweet Tuna Roll",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
                    child: TextField(
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
                    child: Text(
                      "Quantity: [+] 1 [-]",
                      style: Theme.of(context).textTheme.headlineLarge,
                    )
                  ),
                  const SizedBox(height:48),
                  FilledButton(
                    onPressed: (){},
                    child: const Text("Add to Ticket"),
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