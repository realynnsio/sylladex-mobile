import 'package:flutter/material.dart';

class Item {
  static final List<Item> allItems = [
    Item("Placeholder", 1, "Something's in the water here..."),
  ];

  final String name;
  final int amount;
  final String description;

  Item(this.name, this.amount, this.description);
}

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        color: const Color(0xff7f5478),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Set border radius
        ),
        elevation: 5, // Add shadow elevation
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                item.name,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Amount: ${item.amount}',
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                alignment: Alignment.topLeft, // Align text to the left
                child: Text(
                  item.description,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
