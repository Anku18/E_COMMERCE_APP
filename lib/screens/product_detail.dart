import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/widgets/image_swipe.dart';
import 'package:e_commerce_app/widgets/product_size_container.dart';
import '../services/firebase_services.dart';
import '/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/products-detail';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductSize = '0';

  Future<void> _addCart(productId) async {
    return await _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection('Cart')
        .doc(productId)
        .set({'size': _selectedProductSize});
  }

  Future<void> _addToSaved(productId) async {
    return await _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection('Saved')
        .doc(productId)
        .set({'size': _selectedProductSize});
  }

  final SnackBar _snackBar = const SnackBar(
    content: Text('Added to Cart.'),
  );

  final SnackBar _snackBar1 = const SnackBar(
    content: Text('Saved Successfully'),
  );

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(productId).get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error ${snapshot.error}'),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //all document data
                Map<String, dynamic> documentData = snapshot.data!.data();
                // List of images
                List imageList = documentData['images'];
                // data of sizes
                List productSize = documentData['size'];
                // set an initial size
                _selectedProductSize = ('${productSize[0]}');

                return SafeArea(
                  child: ListView(
                    children: [
                      ImageSwipe(
                        imageList: imageList,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24.0,
                          left: 24.0,
                          right: 24.0,
                          bottom: 4.0,
                        ),
                        child: Text(
                          '${documentData['name']}',
                          style: Constants.boldHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 10.0,
                        ),
                        child: Text(
                          '\$${documentData['price']}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 4.0,
                        ),
                        child: Text(
                          '${documentData['desc']}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 24.0,
                        ),
                        child: Text(
                          'Select Size',
                          style: Constants.regularDarkText,
                        ),
                      ),
                      ProductSize(
                        productSize: productSize,
                        onselected: (size) {
                          _selectedProductSize = size;
                        },
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _addToSaved(productId);
                                Scaffold.of(context).showSnackBar(_snackBar1);
                              },
                              child: Container(
                                height: 55.0,
                                width: 55.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCDCDC),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: const Image(
                                  image:
                                      AssetImage('assets/images/bookmark.png'),
                                  height: 25.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _addCart(productId);
                                  Scaffold.of(context).showSnackBar(_snackBar);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Add To Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
            hasBackArrow: true,
            hasTitle: false,
            hasBackground: false,
          ),
        ],
      ),
    );
  }
}
