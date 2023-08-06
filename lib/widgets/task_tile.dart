import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/screens/edit_task_screen.dart';
import 'package:task_app/widgets/popup_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TaskBloc>().add(DeleteTask(task: task))
        : ctx.read<TaskBloc>().add(Removetask(task: task));
  }

  void _editScreen(BuildContext context) {
    print('Edit screen Called');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(oldTask: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        decoration:
                            task.isDone! ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Text(
                      // DateFormat('dd/mm/yyyy').format(DateTime.now()),
                      DateFormat().add_yMEd().add_Hms().format(
                            DateTime.parse(
                              task.date,
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TaskBloc>().add(UpdateTask(task: task));
                      }
                    : null,
              ),
              PopupMenu(
                cancelOrDeleteCallback: () =>
                    _removeOrDeleteTask(context, task),
                task: task,
                likeOrDislikeCallback: () => context
                    .read<TaskBloc>()
                    .add(MarkTaskFavoriteOrUnFavorite(task: task)),
                editTaskCallback: () {
                  _editScreen(context);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}



// ListTile(
//         title: Text(
//           task.title,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             decoration: task.isDone! ? TextDecoration.lineThrough : null,
//           ),
//         ),
//         trailing: Checkbox(
//           value: task.isDone,
//           onChanged: task.isDeleted == false
//               ? (value) {
//                   context.read<TaskBloc>().add(UpdateTask(task: task));
//                 }
//               : null,
//         ),
//         onLongPress: () => _removeOrDeleteTask(context, task));