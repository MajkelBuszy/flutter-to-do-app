// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool isChecked;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  final double borderRadius = 15;

  TaskTile({
    super.key,
    required this.isChecked,
    required this.taskName,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete_forever_rounded,
              backgroundColor: Colors.red.shade400,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: onChanged,
                checkColor: Colors.white,
                side: MaterialStateBorderSide.resolveWith((states) => isChecked
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: Colors.white60)),
              ),
              Text(
                taskName,
                style: TextStyle(
                    color: Colors.white,
                    decoration: isChecked ? TextDecoration.lineThrough : null),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
      ),
    );
  }
}
