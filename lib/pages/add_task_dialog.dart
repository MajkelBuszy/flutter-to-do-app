import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AddTaskDialog extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  AddTaskDialog(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        elevation: 20,
        backgroundColor: Colors.grey[850],
        content: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              style: TextStyle(color: Colors.grey[200]),
              decoration: InputDecoration(
                hintText: "Task Name",
                hintStyle: TextStyle(color: Colors.grey[600]),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[600]!)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[600]!)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onCancel,
                  child: Text("Cancel"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700]),
                ),
                ElevatedButton(onPressed: onSave, child: Text("Add Task")),
              ],
            )
          ],
        )));
  }
}
