import 'package:flutter/material.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_list.dart';

// ignore: must_be_immutable
class PendingTaskScreen extends StatelessWidget {
  const PendingTaskScreen({super.key});

  static const id = 'task_screen';

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
