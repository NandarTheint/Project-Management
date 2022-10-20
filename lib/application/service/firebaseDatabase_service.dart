import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_management/domain/model/project.dart';
import 'package:project_management/data/repository/project_repository.dart';
import 'package:project_management/domain/model/task.dart';

class DataBaseService {
  final ProjectRepository repo = ProjectRepository();

  Future<List<Project>> getProjects() {
    return repo.getProjectList();
  }

  Stream<List<Project>> getProjectListStream(int status) {
    return repo.getProjectListStream(status);
  }

  Future<void> create(Project project) async {
    // projId = 2;
    // projName = 'Driving Liscense';
    // await database.add({"projectName": projName});
    repo.addProject(project);
  }

  Stream<List<Task>> getTasks(String projID) {
    return repo.getTaskList(projID);
  }
}
