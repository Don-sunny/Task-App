import 'package:flutter/material.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/screens/my_drawer.dart';
import 'package:task_app/widgets/task_list.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});

  static const id = 'recycle_bin';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: () => context.read<TaskBloc>().add(
                            DeleteAllTasks(),
                          ),
                      icon: const Icon(
                        Icons.delete_forever,
                      ),
                      label: const Text('Delete all tasks'),
                    ),
                    onTap: () => context.read<TaskBloc>().add(
                          DeleteAllTasks(),
                        ),
                  )
                ],
              )
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            children: [
              Center(
                child: Chip(
                  label: Text('${state.removedTasks.length} Tasks'),
                ),
              ),
              TaskList(
                tasksList: state.removedTasks,
              )
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   tooltip: 'Add task',
          //   child: const Icon(Icons.add),
          // ),
        );
      },
    );
  }
}
