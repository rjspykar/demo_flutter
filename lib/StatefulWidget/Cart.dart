import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart(_productCardState, {super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int qty = 0;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
          onPressed: () {
            if (qty > 0) {
              setState(() {
                qty--;
              });
            }
          },
          icon: const Icon(Icons.remove)),
      Text(qty.toString()),
      IconButton(
          onPressed: () {
            setState(() {
              qty++;
            });
          },
          icon: const Icon(Icons.add)),
    ]);
  }
}
