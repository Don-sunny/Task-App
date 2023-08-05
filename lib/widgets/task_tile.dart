import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc/task_bloc.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TaskBloc>().add(DeleteTask(task: task))
        : ctx.read<TaskBloc>().add(Removetask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone! ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          value: task.isDone,
          onChanged: (value) {
            context.read<TaskBloc>().add(UpdateTask(task: task));
          },
        ),
        onLongPress: () => _removeOrDeleteTask(context, task));
  }
}
