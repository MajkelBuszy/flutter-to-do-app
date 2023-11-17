import 'package:fluter_to_do_app/components/task_tile.dart';
import 'package:fluter_to_do_app/pages/add_task_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class Task {
  final String taskName;
  bool isChecked;

  Task({required this.taskName, required this.isChecked});
}

class _HomePageState extends State<HomePage> {
  final _taskBox = Hive.openBox("taskBox");

  final _controller = TextEditingController();

  List<Task> TaskList = [
    Task(taskName: "Task 1", isChecked: false),
    Task(taskName: "Task 2", isChecked: false),
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      TaskList[index].isChecked = !TaskList[index].isChecked;
    });
  }

  void saveTask() {
    setState(() {
      Task newTask = Task(taskName: _controller.text, isChecked: false);
      TaskList.add(newTask);
    });
    Navigator.of(context).pop();
    _controller.clear();
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
      TaskList.removeAt(index);
    });
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
        itemCount: TaskList.length,
        itemBuilder: (context, index) {
          return TaskTile(
              isChecked: TaskList[index].isChecked,
              taskName: TaskList[index].taskName,
              onChanged: (value) => checkBoxChanged(value!, index),
              deleteTask: (context) => deleteTask(index));
        },
      ),
    ));
  }
}
