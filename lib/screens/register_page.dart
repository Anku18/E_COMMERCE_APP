import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/custom_btn.dart';
import '../widgets/custom_input.dart';

class ResgisterPage extends StatefulWidget {
  static const routeName = '/registerpage';
  @override
  State<ResgisterPage> createState() => _ResgisterPageState();
}

class _ResgisterPageState extends State<ResgisterPage> {
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

  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
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
      _registerFormLoading = true;
    });

    //runing the create account
    String _createAccountFeedback = await _createAccount();

    //if the string is not null , we got error while create account
    if (_createAccountFeedback != null.toString()) {
      _alertDialogBuilder(_createAccountFeedback);

      //set the form to regular state---  NOT LOADING..
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      //the string was null , create account  successful , back to login page.
      Navigator.of(context).pop();
    }
  }

  bool _registerFormLoading = false;

  // Input field value
  String _registerEmail = '';
  String _registerPassword = '';

  //focus node for input fields
  FocusNode? _passwordFocusNode;

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
                  'Create A New Account',
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              // column of input fields and create btn.
              Column(
                children: [
                  CustomInput(
                    hintText: 'Email',
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode!.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: 'Password',
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode!,
                    isPasswordFields: true,
                    onSubmitted: (_) {
                      _submitForm();
                    },
                  ),
                  // CustomInput('Confirm Password'),
                  CustomBtn(
                    text: 'Create New Account',
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _registerFormLoading,
                  ),
                ],
              ),
              //Back to login btn.
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomBtn(
                  text: 'Back To Login',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  outLineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
