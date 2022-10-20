import 'package:flutter/material.dart';
import 'package:project_management/application/service/auth_service.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required AuthService authService,
    required this.email,
    required this.password,
    required this.buttonName,
    required this.onPressed,
  })  : _formKey = formKey,
        _authService = authService,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final AuthService _authService;
  final String email;
  final String password;
  final String buttonName;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed(),
      fillColor: Colors.teal[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
