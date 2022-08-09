import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String getUserId() {
    return _firebaseAuth.currentUser!.uid;
  }

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('Users');
}
