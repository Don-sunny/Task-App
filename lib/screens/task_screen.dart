import 'package:flutter/material.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_list.dart';

// ignore: must_be_immutable
class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  static const id = 'task_screen';

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasksList = state.pendingTasks;
        return Column(
          children: [
            Center(
              child: Chip(
                label: Text('${state.pendingTasks.length} Tasks'),
              ),
            ),
            TaskList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}
