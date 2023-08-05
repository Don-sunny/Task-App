import 'package:flutter/material.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/services/guid_gen.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Add Task',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
                label: Text('Title'), border: OutlineInputBorder()),
            autofocus: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  var task = Task(
                    title: titleController.text,
                    id: GUIDGen.generate(),
                  );
                  context.read<TaskBloc>().add(
                        AddTask(task: task),
                      );
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
