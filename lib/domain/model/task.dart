class Task {
  final String projectID;
  final String projectName;
  final String taskID;
  final String taskName;
  final int status;

  Task(
      {required this.projectID,
      required this.projectName,
      required this.taskID,
      required this.taskName,
      required this.status});

  factory Task.createTaskFromDoc(Map<String, dynamic> doc) => Task(
      projectID: doc['projectID'],
      projectName: doc['projectName'],
      taskID: doc['taskID'],
      taskName: doc['taskName'],
      status: 0);

  factory Task.createTask(String projID, String projName, String taskID,
          String taskName, int status) =>
      Task(
          projectID: projID,
          projectName: projName,
          taskID: taskID,
          taskName: taskName,
          status: status);
}
