import 'package:demo_flutter/Bean/Item.dart';
import 'package:demo_flutter/StatefulWidget/ProductCard.dart';
import 'package:demo_flutter/controllers/item_controller.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  ProductList({super.key});
  List<Product> list = [];
  int totalQty = 0;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  /*
  Create List for getting items.
  createFunction to populate list at initstate();
  handle onclick functions for each component.
  */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.list = [];
    ItemController().fetchData().then((value) => setState(() {
          widget.list.addAll(value);
        }));
  }

  @override
  void didUpdateWidget(covariant ProductList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    widget.list = [];
    ItemController().fetchData().then((value) => setState(() {
          widget.list.addAll(value);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product List"),
        ),
        body: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              return ProductCard(product: widget.list[index]);
            }),
        persistentFooterButtons: [
          RawMaterialButton(child: const Text("Save"), onPressed: () {}),
          OutlinedButton(
              onPressed: () {}, child: Text(widget.totalQty.toString())),
        ]);
  }
}
