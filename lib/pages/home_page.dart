import 'package:fluter_to_do_app/components/task_tile.dart';
import 'package:fluter_to_do_app/data/database.dart';
import 'package:fluter_to_do_app/pages/add_task_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _taskBox = Hive.box("taskBox");
  TaskDatabase db = TaskDatabase();

  final _controller = TextEditingController();

  @override
  void initState() {
    if (_taskBox.get("TASKLIST") == null) {
      db.createInitialDbData();
    } else {
      db.loadDbData();
    }

    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    try {
      setState(() {
        db.taskList[index]["isChecked"] = !db.taskList[index]["isChecked"];
      });
      db.updateDbData();
    } catch (e) {
      print(e.toString());
    }
  }

  void saveTask() {
    setState(() {
      var newTask = {"taskName": _controller.text, "isChecked": false};
      db.taskList.add(newTask);
    });
    Navigator.of(context).pop();
    _controller.clear();
    db.updateDbData();
  }

  void createTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AddTaskDialog(
            controller: _controller,
            onSave: saveTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.taskList.removeAt(index);
    });
    db.updateDbData();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Tasks"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: Icon(Icons.add),
        enableFeedback: true,
      ),
      body: ListView.builder(
        itemCount: db.taskList.length,
        itemBuilder: (context, index) {
          return TaskTile(
              isChecked: db.taskList[index]["isChecked"],
              taskName: db.taskList[index]["taskName"],
              onChanged: (value) => checkBoxChanged(value!, index),
              deleteTask: (context) => deleteTask(index));
        },
      ),
    ));
  }
}
