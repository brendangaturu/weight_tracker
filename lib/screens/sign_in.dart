import 'package:flutter/material.dart';
import 'package:weight_tracker/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _auth  = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                // side: BorderSide(),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                alignment: Alignment.center),
            child: Text('Sign In'),
            onPressed: () async {
              await _auth.signInAnon();
            },
          ),
        ),
      ),
    );
  }
}
