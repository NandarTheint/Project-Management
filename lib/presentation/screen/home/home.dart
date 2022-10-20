import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_management/application/service/auth_service.dart';
import 'package:project_management/application/service/firebaseDatabase_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_management/component/costants.dart';
import 'package:project_management/domain/model/task.dart';
import 'package:project_management/presentation/project_detail.dart';
import 'package:project_management/presentation/screen/create_project.dart';
import 'package:intl/intl.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../../../domain/model/project.dart';

class Home extends StatefulWidget {
  final AuthService _authenticate = AuthService();
  final DataBaseService _dataBaseService = DataBaseService();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Map<int, Widget> _segments = {
    statusNotStarted: Text('Not Started'),
    statusOnProgress: Text('On Progress'),
    statusFinished: Text('Finished'),
  };
  int _currentSegmentIndex = 1;
  late int projectID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text('PROJECT MANAGER'),
        actions: <Widget>[
          TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.grey[400]),
            ),
            onPressed: () async {
              await widget._authenticate.signOut();
            },
            icon: const Icon(FontAwesomeIcons.rightFromBracket),
            label: const Text('Logout'),
          ),
        ],
      ),
      backgroundColor: Colors.teal[50],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
            child: MaterialSegmentedControl(
              children: _segments,
              selectionIndex: _currentSegmentIndex,
              selectedColor: Color(0xFF3FA796),
              unselectedColor: Colors.white,
              //borderColor: Color(0xFF3FA796),
              verticalOffset: 12,
              onSegmentChosen: (int index) => {
                setState(() {
                  _currentSegmentIndex = index;
                })
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Project>>(
              stream: widget._dataBaseService
                  .getProjectListStream(_currentSegmentIndex),
              builder: (context, AsyncSnapshot<List<Project>> projList) {
                if (projList.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (projList.hasData) {
                  int listCnt = projList.data!.length;

                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    primary: false,
                    itemCount: projList.data!.length,
                    itemBuilder: (context, index) {
                      return ProjectCard(
                        projList: projList,
                        index: index,
                        currentSegmentIndex: _currentSegmentIndex,
                      );
                    },
                  );
                }

                if (projList.hasError) {
                  return Text(projList.error.toString());
                }

                return const Text('no data');
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateProject()));
        },
        backgroundColor: Color(0xFFFF0063),
        // foregroundColor: Color(0xFF18978F),
        icon: Icon(FontAwesomeIcons.squarePlus),
        label: Text('New Project'),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        extendedPadding: EdgeInsets.all(8.0),
        hoverColor: const Color.fromARGB(255, 189, 89, 127),
      ),
    );
  }
}

//** projecct card widget */
class ProjectCard extends StatelessWidget {
  final AsyncSnapshot<List<Project>> projList;
  final int index;
  final int currentSegmentIndex;

  const ProjectCard(
      {required this.projList,
      required this.index,
      required this.currentSegmentIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      borderOnForeground: true,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                StatusIcon(status: currentSegmentIndex),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  projList.data![index].projectID,
                  style: projectIDTextStyle,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: Text(
                projList.data![index].projectName,
                style: projectCardTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 15,
                  color: Colors.grey[600],
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  'Project Date',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Text(
              '${DateFormat('yyyy-MM-dd').format(projList.data![index].projectStartDate)} 〜 ${DateFormat('yyyy-MM-dd').format(projList.data![index].projectEndDate)}',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    primary: Color(0xFF82DBD8),
                    shadowColor: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ProjectDetail(
                                projectID: projList.data![index].projectID))));
                  },
                  child: Text('Details'),
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    primary: Color(0xFF82DBD8),
                    shadowColor: Colors.teal,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

//** Status Icon */
class StatusIcon extends StatelessWidget {
  StatusIcon({required this.status});

  final int status;

  @override
  Widget build(BuildContext context) {
    Icon icon = Icon(
      FontAwesomeIcons.clipboardList,
      color: Colors.teal[300],
    );
    if (status == statusNotStarted) {
      icon = Icon(
        FontAwesomeIcons.clipboardList,
        color: Colors.teal[300],
      );
    } else if (status == statusOnProgress) {
      icon = Icon(
        Icons.rowing,
        color: Colors.teal[300],
      );
    } else if (status == statusFinished) {
      icon = Icon(
        Icons.check_circle,
        color: Colors.teal[300],
      );
    }
    return icon;
  }
}
