import 'package:flutter/material.dart';

typedef void StringCallBack(String text);

class ProjectTextFormField extends StatefulWidget {
  const ProjectTextFormField({required this.callBack, required this.labelText});

  final StringCallBack callBack;
  final String labelText;

  @override
  State<ProjectTextFormField> createState() => _ProjectTextFormFieldState();
}

class _ProjectTextFormFieldState extends State<ProjectTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 7, 71, 67),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 6, 108, 101),
            width: 4.0,
          ),
        ),
      ),
      onChanged: (val) => widget.callBack(val),
    );
  }
}
