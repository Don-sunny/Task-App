import 'package:flutter/material.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_list.dart';

// ignore: must_be_immutable
class CompletedTasksSCreen extends StatelessWidget {
  const CompletedTasksSCreen({super.key});

  static const id = 'task_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasksList = state.completedTasks;
        return Column(
          children: [
            Center(
              child: Chip(
                label: Text('${state.completedTasks.length} Tasks'),
              ),
            ),
            TaskList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}
