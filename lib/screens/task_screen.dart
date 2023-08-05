import 'package:flutter/material.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/screens/add_task_screen.dart';
import 'package:task_app/screens/my_drawer.dart';
import 'package:task_app/widgets/task_list.dart';

// ignore: must_be_immutable
class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  static const id = 'task_screen';

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks App'),
            actions: [
              IconButton(
                onPressed: () => _addTask(context),
                icon: const Icon(Icons.add),
              )
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            children: [
              Center(
                child: Chip(
                  label: Text('${state.allTasks.length} Tasks'),
                ),
              ),
              TaskList(tasksList: tasksList)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
