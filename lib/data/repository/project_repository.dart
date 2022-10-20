import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_management/domain/model/project.dart';
import 'package:project_management/application/service/firebaseDatabase_service.dart';
import 'package:collection/collection.dart';
import 'package:project_management/domain/model/task.dart';

class ProjectRepository {
  final CollectionReference<Map<String, dynamic>> projectCollectionReference =
      FirebaseFirestore.instance.collection('projects');

  final CollectionReference<Map<String, dynamic>> taskCollectionReference =
      FirebaseFirestore.instance.collection('tasks');

  // get projects list
  Future<List<Project>> getProjectList() async {
    QuerySnapshot<Map<String, dynamic>> snapshots =
        await projectCollectionReference.get();
    return snapshots.docs.map(mapToProject).toList();
  }

  //get projects list as stream
  Stream<List<Project>> getProjectListStream(int status) {
    return projectCollectionReference
        .where('status',
            isEqualTo: status) // TODO:set the dynameic status filter
        .snapshots()
        .asyncMap((snap) => snap.docs.map(mapToProject).toList());
  }

  // map document to project model
  Project mapToProject(DocumentSnapshot<Map<String, dynamic>> doc) {
    dynamic documentId = doc.id;
    return Project.createProject(documentId, doc.data()!);
  }

  // create new project
  Future<void> addProject(Project project) async {
    projectCollectionReference.doc(project.projectID).set({
      'projectName': project.projectName,
      'projectStartDate': project.projectStartDate,
      'projectEndDate': project.projectEndDate,
      'status': project.status,
    }).onError((e, _) => print("Error writing document: $e"));
  }

  static getGroupByStatusList(List<Map<String, dynamic>> projects) {
    groupBy(projects, (Map<String, dynamic> project) {
      return project['status'];
    });
  }

  // get task list of selected project
  Stream<List<Task>> getTaskList(String projID) {
    return taskCollectionReference
        .where('projectID', isEqualTo: projID.toString())
        .snapshots()
        .asyncMap((snap) => snap.docs.map(mapToTask).toList());
  }

  // map document to task
  Task mapToTask(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Task.createTaskFromDoc(doc.data()!);
  }
}
