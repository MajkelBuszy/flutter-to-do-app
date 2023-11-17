import 'package:hive_flutter/hive_flutter.dart';

class TaskDatabase {
  List taskList = [];

  final _taskBox = Hive.box("taskBox");

  void createInitialDbData() {
    taskList = [
      {"taskName": "Make New Task", "isChecked": false},
      {"taskName": "Delete Task", "isChecked": false},
    ];
  }

  void loadDbData() {
    taskList = _taskBox.get("TASKLIST");
  }

  void updateDbData() {
    _taskBox.put("TASKLIST", taskList);
  }
}
