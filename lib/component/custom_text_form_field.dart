import 'package:flutter/material.dart';

typedef void StringCallBack(String text);

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    required this.hintText,
    required this.callBack,
    required this.propName,
    required this.errorMsg,
    required this.isObsecureText,
    required this.isValidated,
  });

  final String hintText;
  final StringCallBack callBack;
  final String propName;
  final String errorMsg;
  final bool isObsecureText;
  final bool isValidated;

  TextEditingController myController = TextEditingController();

  TextEditingController get Controller {
    return myController;
  }

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.isObsecureText,
      onChanged: (val) => setState(() {
        widget.callBack(val);
      }),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 6, 108, 101),
            width: 4.0,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        focusColor: const Color.fromARGB(255, 4, 42, 38),
      ),
      validator: (val) {
        if (widget.isValidated) {
          widget.propName.isEmpty ? widget.errorMsg : null;
        }
        return null;
      },
      cursorColor: Colors.teal[800],
      cursorHeight: 25,
    );
  }
}
