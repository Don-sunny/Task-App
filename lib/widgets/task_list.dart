import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasksList,
  });

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasksList.length,
        itemBuilder: (context, index) {
          var task = tasksList[index];
          return TaskTile(task: task);
        },
      ),
    );
  }
}
