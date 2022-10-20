import 'package:flutter/material.dart';
import 'package:project_management/application/service/auth_service.dart';
import 'package:project_management/component/custom_appBar.dart';
import 'package:project_management/component/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_management/component/costants.dart';

class Register extends StatefulWidget {
  final Function toggleForms;

  Register({required this.toggleForms});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String errmsg = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      // Custom AppBar
      appBar: CustomAppBar(
        toggleForm: widget.toggleForms,
        iconName: 'LogIn',
        title: 'Register to ProjectManager',
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
              const SizedBox(
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
              const SizedBox(
                height: 20,
              ),
              RawMaterialButton(
                onPressed: () async {
                  errmsg = '';
                  if (_formKey.currentState!.validate()) {
                    try {
                      await _authService.register(email, password);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'invalid-email') {
                        setState(() {
                          errmsg = 'Enter valid email and password!';
                        });
                      }
                    }
                  }
                },
                fillColor: Colors.teal[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'REGISTER',
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
