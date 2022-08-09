import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_app/services/firebase_services.dart';
import 'package:e_commerce_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/product_detail.dart';
import '../widgets/product_card.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: [
            if (_searchString.isEmpty)
              Center(
                child: Container(
                  child: const Text(
                    'Search Results',
                    style: Constants.regularDarkText,
                  ),
                ),
              ),
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productsRef
                  .orderBy('name')
                  .startAt([_searchString]).endAt([_searchString]).get(),
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
                      padding: const EdgeInsets.only(top: 80, bottom: 2),
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
            CustomInput(
                hintText: 'Search here....',
                onSubmitted: (value) {
                  setState(() {
                    _searchString = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
