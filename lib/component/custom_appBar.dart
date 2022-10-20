import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar(
      {required this.toggleForm, required this.iconName, required this.title})
      : preferredSize = const Size.fromHeight(50.0);

  @override
  final Size preferredSize;
  final Function toggleForm;
  final String iconName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal[400],
      title: Text(title),
      actions: <Widget>[
        TextButton.icon(
          onPressed: () {
            toggleForm();
          },
          icon: const Icon(Icons.person),
          label: Text(iconName),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.grey[400]),
          ),
        ),
      ],
    );
  }
}
