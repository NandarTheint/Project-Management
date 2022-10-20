import 'package:flutter/material.dart';
import '../../application/service/auth_service.dart';
import 'package:project_management/application/service/firebaseDatabase_service.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final AuthService _authenticate = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text('CREATE TASK'),
        actions: <Widget>[
          TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.grey[400]),
            ),
            onPressed: () async {
              await _authenticate.signOut();
            },
            icon: const Icon(Icons.person),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
