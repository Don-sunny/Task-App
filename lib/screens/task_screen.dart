import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  List<Task> tasksList = [
    Task(title: 'Task 1'),
    Task(title: 'Task 2'),
    Task(title: 'Task 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Center(
            child: Chip(
              label: Text('Tasks'),
            ),
          ),
          ListView.builder(
            itemCount: tasksList.length,
            itemBuilder: (context, index) {},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
