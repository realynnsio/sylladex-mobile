import 'package:flutter/material.dart';
import 'package:sylladex_mobile/models/product.dart';
import 'package:sylladex_mobile/widgets/left_drawer.dart';
// import 'package:sylladex_mobile/widgets/item_card.dart';

class ItemListPage extends StatelessWidget {
  final Product item;
  const ItemListPage({Key? key, required this.item}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Item',
          ),
          backgroundColor: const Color(0xff3e2f48), //added colour for appbar!
          foregroundColor: Colors.white,
        ),
        // drawer: const LeftDrawer(),
        body: Material(
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
                    item.fields.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Amount: ${item.fields.amount}',
                    style: TextStyle(color: Colors.white.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    alignment: Alignment.topLeft, // Align text to the left
                    child: Text(
                      item.fields.description,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
