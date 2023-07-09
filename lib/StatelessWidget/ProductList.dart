import 'package:demo_flutter/Bean/Item.dart';
import 'package:demo_flutter/StatefulWidget/ProductCard.dart';
import 'package:demo_flutter/controllers/item_controller.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> list = [];
  int totalQty = 0;

  /*
  Create List for getting items.
  createFunction to populate list at initstate();
  handle onclick functions for each component.
  */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = [];
    ItemController().fetchData().then((value) => setState(() {
          list.addAll(value);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product List"),
        ),
        body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ProductCard(product: list[index]);
            }),
        persistentFooterButtons: [
          OutlinedButton(onPressed: () {}, child: Text(totalQty.toString())),
        ]);
  }
}
