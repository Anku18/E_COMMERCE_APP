import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/product_detail.dart';

class ProductCard extends StatelessWidget {
  final String? productId;
  final VoidCallback? onPressed;
  final String? imageUrl;
  final String? title;
  final String? price;

  ProductCard({
    this.productId,
    this.onPressed,
    this.imageUrl,
    this.title,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 350,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Stack(
          children: [
            Container(
              height: 350,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  '$imageUrl',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title!, style: Constants.regularHeading),
                    Text(
                      price!,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
