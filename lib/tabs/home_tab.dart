import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screens/product_detail.dart';
import 'package:e_commerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_action_bar.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error ${snapshot.error}'),
                  ),
                );
              }

              // Collection Data is Fetch successfully
              // showing on screen
              if (snapshot.connectionState == ConnectionState.done) {
                return SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 65, bottom: 2),
                    children: snapshot.data!.docs.map((document) {
                      return ProductCard(
                        title: (document.data() as Map)['name'],
                        imageUrl: (document.data() as Map)['images'][0],
                        price: '\$${(document.data() as Map)['price']}',
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            ProductPage.routeName,
                            arguments: document.id,
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              }

              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: 'Home',
            hasBackArrow: false,
            hasTitle: true,
          ),
        ],
      ),
    );
  }
}
