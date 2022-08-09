import 'package:e_commerce_app/screens/cart_page.dart';
import 'package:e_commerce_app/screens/product_detail.dart';
import 'package:e_commerce_app/screens/register_page.dart';

import '/screens/landing_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: const Color(0xFFFF1E00),
      ),
      home: LandingPage(),
      routes: {
        ResgisterPage.routeName: (context) => ResgisterPage(),
        ProductPage.routeName: (context) => ProductPage(),
        CartPage.routeName: (context) => CartPage(),
      },
    );
  }
}
