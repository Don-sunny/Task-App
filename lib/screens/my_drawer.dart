import 'package:flutter/material.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/screens/recycle_bin.dart';
import 'package:task_app/screens/task_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.grey,
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(TaskScreen.id),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text('My Tasks'),
                    trailing: Text('${state.allTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(RecycleBin.id),
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Bin'),
                    trailing: Text('${state.removedTasks.length}'),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}