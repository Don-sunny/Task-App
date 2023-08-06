import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasksList,
  });

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
            children: tasksList
                .map(
                  (task) => ExpansionPanelRadio(
                    value: task.id,
                    headerBuilder: (context, isExpanded) =>
                        TaskTile(task: task),
                    body: ListTile(
                      title: SelectableText.rich(TextSpan(children: [
                        const TextSpan(
                          text: 'Title\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: task.title),
                        const TextSpan(
                          text: '\n\nDescription\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: task.description)
                      ])),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}


// Expanded(
//       child: ListView.builder(
//         itemCount: tasksList.length,
//         itemBuilder: (context, index) {
//           var task = tasksList[index];
//           return TaskTile(task: task);
//         },
//       ),
//     );