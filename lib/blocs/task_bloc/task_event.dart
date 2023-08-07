part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}

class Removetask extends TaskEvent {
  final Task task;

  const Removetask({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}

class MarkTaskFavoriteOrUnFavorite extends TaskEvent {
  final Task task;

  const MarkTaskFavoriteOrUnFavorite({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}

class EditTask extends TaskEvent {
  final Task oldTask;
  final Task newTask;

  const EditTask({
    required this.oldTask,
    required this.newTask,
  });
  @override
  List<Object> get props => [oldTask, newTask];
}

class RestoreTask extends TaskEvent {
  final Task task;
  const RestoreTask({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteAllTasks extends TaskEvent {}
