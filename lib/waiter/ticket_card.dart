import 'package:flutter/material.dart';

/* Currently a static widget. TODO: load proper data into widget upon construction. */
class TicketCard extends StatelessWidget {
  const TicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                "Table 41",
                style: Theme.of(context).textTheme.headlineSmall
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,0,12),
              child: Text(
                "STATUS: OPEN",
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
            const Divider(height:0,),
            Dish(),
            Dish(),
            const Divider(height:0,),
            const SizedBox(height:12),
            Row(
              children: [
                const SizedBox.square(dimension: 16),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: (){
                      Navigator.pushNamed(context, "/AddDishPage");
                    }, //TODO
                    child: const Text("Add Dish"),
                  ),
                ),
                const SizedBox.square(dimension: 16),
                FilledButton(
                  onPressed: (){}, //TODO
                  child: const Icon(Icons.payment),
                ),
                const SizedBox.square(dimension: 16),
              ],
            ),
            const SizedBox(height:12),
          ],
        ),
      )
    );
  }
}

class Dish extends StatelessWidget {
  const Dish({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.onPrimary,
      title: Text("1 California Roll"),
      subtitle: Text("No tomato, add onion."),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.remove_circle)
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