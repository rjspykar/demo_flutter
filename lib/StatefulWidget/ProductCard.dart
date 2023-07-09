import 'package:flutter/material.dart';

import '../Bean/Item.dart';
import 'Cart.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return getProductCard(widget.product);
  }

  Widget getProductCard(Product product) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.currency_rupee_rounded),
                    label: Text(product.price.value.toString())),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // Add your favorite button logic here
                  },
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Cart(),
            SizedBox(height: 8),
            Text(
              product.category,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
