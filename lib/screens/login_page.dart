import 'package:e_commerce_app/screens/register_page.dart';
import 'package:e_commerce_app/widgets/custom_btn.dart';
import 'package:e_commerce_app/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //alert dialogs for error
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Container(
            child: Text(error),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null.toString();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak password') {
        return 'The Password is to weak';
      } else if (error.code == 'emaill-already in use') {
        return 'The email is already exists';
      }
      return error.message!;
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> _submitForm() async {
    //set the form to loading state
    setState(() {
      _loginFormLoading = true;
    });

    //runing the create account
    String _loginFeedback = await _loginAccount();

    //if the string is not null , we got error while create account
    if (_loginFeedback != null.toString()) {
      _alertDialogBuilder(_loginFeedback);

      //set the form to regular state---  NOT LOADING..
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  bool _loginFormLoading = false;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode!.dispose();
    super.dispose();
  }

  // Input field value
  String _loginEmail = '';
  String _loginPassword = '';

  //focus node for input fields
  FocusNode? _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Heading Text
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  'Welcome User,\n Login to your account',
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              // column of input fields and login btn.
              Column(
                children: [
                  CustomInput(
                    hintText: 'Email',
                    onChanged: (value) {
                      _loginEmail = value;
                    },
                    onSubmitted: (_) {
                      _passwordFocusNode!.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: 'Password',
                    onChanged: (value) {
                      _loginPassword = value;
                    },
                    onSubmitted: (_) {
                      _submitForm();
                    },
                    focusNode: _passwordFocusNode!,
                    isPasswordFields: true,
                  ),
                  CustomBtn(
                    text: 'Login',
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _loginFormLoading,
                  ),
                ],
              ),
              //create new account btn.
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomBtn(
                  text: 'Create New Account',
                  onPressed: () {
                    Navigator.of(context).pushNamed(ResgisterPage.routeName);
                  },
                  outLineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
