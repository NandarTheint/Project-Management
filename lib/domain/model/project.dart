import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String projectID;
  final String projectName;
  final DateTime projectStartDate;
  final DateTime projectEndDate;
  final int status;

  Project({
    required this.projectID,
    required this.projectName,
    required this.projectStartDate,
    required this.projectEndDate,
    required this.status,
  });

  factory Project.createProject(dynamic documentId, Map<String, dynamic> doc) =>
      Project(
          projectID: documentId,
          projectName: doc['projectName'],
          projectStartDate: (doc['projectStartDate'] as Timestamp).toDate(),
          projectEndDate: (doc['projectEndDate'] as Timestamp).toDate(),
          status: doc['status']);
}
