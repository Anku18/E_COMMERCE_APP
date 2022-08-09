import 'package:e_commerce_app/screens/home_page.dart';
import 'package:e_commerce_app/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // If snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error ${snapshot.error}'),
            ),
          );
        }

        // Connection Initialzed - Firebase App is running
        //................................................

        if (snapshot.connectionState == ConnectionState.done) {
          // streambuilder  can check the login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              // if stream Snapshot has error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error ${streamSnapshot.error}'),
                  ),
                );
              }

              // Connection state active  - Do the user login check inside the if statement
              if (streamSnapshot.connectionState == ConnectionState.active) {
                //get the  user
                User? _user = streamSnapshot.data as User?;

                if (_user == null) {
                  return LoginPage();
                } else {
                  return HomePage();
                }
              }

              // checking the auth state -- loading
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        }

        // Connecting to Firebase - Loading
        return const Scaffold(
          body: Center(
            child: Text(
              'Initializing App...........',
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
