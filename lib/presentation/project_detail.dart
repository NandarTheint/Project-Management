import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_management/application/service/firebaseDatabase_service.dart';
import 'package:project_management/presentation/create_task.dart';
import '../../application/service/auth_service.dart';
import '../domain/model/task.dart';

class ProjectDetail extends StatefulWidget {
  const ProjectDetail({required this.projectID});

  final projectID;

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  final AuthService _authenticate = AuthService();
  final DataBaseService _dataBaseService = DataBaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text('Project Detail'),
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
      body: StreamBuilder<List<Task>>(
          stream: _dataBaseService.getTasks(widget.projectID),
          builder: (context, AsyncSnapshot<List<Task>> taskList) {
            if (taskList.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (taskList.hasData) {
              return Text(taskList.data![0].taskName);
            }
            return const Text('no data');
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateTask()));
        },
        backgroundColor: Color(0xFFFF0063),
        // foregroundColor: Colors.lightGreenAccent,
        icon: Icon(FontAwesomeIcons.squarePlus),
        label: Text('New Task'),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        extendedPadding: EdgeInsets.all(8.0),
        hoverColor: const Color.fromARGB(255, 189, 89, 127),
      ),
    );
  }
}
