// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_management/component/costants.dart';
import 'package:project_management/component/custom_appBar.dart';
import 'package:project_management/application/service/auth_service.dart';
import 'package:project_management/component/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleForms;

  SignIn({required this.toggleForms});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String errmsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: CustomAppBar(
        toggleForm: widget.toggleForms,
        iconName: 'Register',
        title: 'SignIn to ProjectManager',
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // email
              TextFormField(
                onChanged: (val) => setState(() {
                  email = val;
                }),
                decoration: authenticateTextDecoration,
                validator: (val) {
                  return val == null || val.isEmpty ? 'Enter email' : null;
                },
                cursorColor: Colors.teal[800],
                cursorHeight: 25,
              ),
              SizedBox(
                height: 20,
              ),
              // password
              TextFormField(
                obscureText: true,
                onChanged: (val) => setState(() {
                  password = val;
                }),
                decoration: authenticateTextDecoration,
                validator: (val) {
                  return val == null || val.isEmpty
                      ? 'Enter your password'
                      : null;
                },
                cursorColor: Colors.teal[800],
                cursorHeight: 25,
              ),
              SizedBox(
                height: 20,
              ),
              RawMaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await _authService.SignInWithEmailAndPass(
                          email, password);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        setState(() {
                          errmsg = 'User Not Found!';
                        });
                      }
                      if (e.code == 'wrong-password') {
                        setState(() {
                          errmsg = 'Wrong Password!';
                        });
                      }
                    }
                  }
                },
                fillColor: Colors.teal[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  errmsg,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
