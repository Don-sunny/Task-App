import 'package:flutter/material.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_list.dart';

// ignore: must_be_immutable
class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({super.key});

  static const id = 'task_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasksList = state.favoriteTasks;
        return Column(
          children: [
            Center(
              child: Chip(
                label: Text('${state.favoriteTasks.length} Tasks'),
              ),
            ),
            TaskList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}
