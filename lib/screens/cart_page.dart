import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/services/firebase_services.dart';
import 'package:e_commerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

import 'product_detail.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cart-page';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: true,
            title: 'Cart',
          ),
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef
                .doc(_firebaseServices.getUserId())
                .collection('Cart')
                .get(),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ProductPage.routeName,
                            arguments: document.id,
                          );
                        },
                        child: FutureBuilder(
                          future: _firebaseServices.productsRef
                              .doc(document.id)
                              .get(),
                          builder: (context, AsyncSnapshot productSnap) {
                            if (productSnap.hasError) {
                              return Container(
                                child: Center(
                                  child: Text('${productSnap.error}'),
                                ),
                              );
                            }

                            if (productSnap.connectionState ==
                                ConnectionState.done) {
                              Map _productMap = productSnap.data.data();

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 24.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          '${_productMap['images'][0]}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${_productMap['name']}',
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: Text(
                                              '\$${_productMap['price']}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Size - ${(document.data() as Map)['size']}',
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Container(
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
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
        ],
      ),
    );
  }
}
