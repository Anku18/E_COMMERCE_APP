import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/cart_page.dart';

import 'package:flutter/material.dart';

import '../services/firebase_services.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool? hasBackArrow;
  final bool? hasTitle;
  final bool? hasBackground;

  CustomActionBar(
      {this.title, this.hasBackArrow, this.hasTitle, this.hasBackground});

  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('Users');

  final FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? false;
    bool _hasBackground = hasBackground ?? true;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                  begin: const Alignment(0, 0),
                  end: const Alignment(0, 1),
                )
              : null,
        ),
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 24.0,
          right: 24.0,
          bottom: 28.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_hasBackArrow)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 42.0,
                  width: 42.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: const Image(
                    image: AssetImage('assets/images/back.png'),
                    height: 16.0,
                    width: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            if (_hasTitle)
              Text(
                title!,
                style: Constants.boldHeading,
              ),
            // Cart icon
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
              child: Container(
                height: 42.0,
                width: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: StreamBuilder(
                  stream: _userRef
                      .doc(_firebaseServices.getUserId())
                      .collection('Cart')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    int _totalItems = 0;

                    if (snapshot.connectionState == ConnectionState.active) {
                      List _documents = snapshot.data!.docs;
                      _totalItems = _documents.length;
                    }

                    return Text(
                      '$_totalItems',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
