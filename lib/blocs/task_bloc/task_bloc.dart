import 'package:equatable/equatable.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    // Registering event handler functions for different events
    // These functions are called when corresponding events are dispatched.
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<Removetask>(_onRemoveTask);
    on<MarkTaskFavoriteOrUnFavorite>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
  }

  // Event handler function for AddTask event

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    // Update the state by adding the new task to the pendingTasks list
    emit(
      TaskState(
          pendingTasks: List.from(state.pendingTasks)..add(event.task),
          completedTasks: state.completedTasks,
          favoriteTasks: state.favoriteTasks,
          removedTasks: state.removedTasks),
    );
  }

  // Event handler function for UpdateTask event
  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;

    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true))
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false))
          };
    // Update the state by moving the task between pendingTasks and completedTasks lists based on its isDone status
    // If the task is done, move it from pending to completed, and vice versa.
    // Also, update the isDone status of the task accordingly.
    // The event carries the task that needs to be updated.
    // This function ensures that the task is in the correct list and its isDone status is updated.

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  // Event handler function for DeleteTask event
  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    // Update the state by removing the task from the removedTasks list
    emit(
      TaskState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)
          ..remove(
            event.task,
          ),
      ),
    );
  }

  void _onRemoveTask(Removetask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(
            event.task.copyWith(isDeleted: true),
          ),
      ),
    );
  }

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkTaskFavoriteOrUnFavorite event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks = List.from(favoriteTasks)
          ..insert(0, event.task.copyWith(isFavorite: true));
        // favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }
    emit(TaskState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onEditTask(EditTask event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(
      TaskState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: state.completedTasks..remove(event.oldTask),
        favoriteTasks: favouriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  // Function to handle the restoration of a task (restoring from deleted tasks)
  void _onRestoreTask(RestoreTask event, Emitter<TaskState> emit) {
    final state = this.state;
    // Update the state by restoring the task from the removedTasks list
    emit(
      TaskState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(
              0,
              event.task.copyWith(
                isDeleted: false,
                isDone: false,
                isFavorite: false,
              )),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  // Function to handle deleting all tasks
  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TaskState> emit) {
    // Update the state by clearing the removedTasks list (i.e., removing all tasks)
    final state = this.state;
    emit(
      TaskState(
        removedTasks: List.from(state.removedTasks)..clear(),
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  // Function to convert the state to JSON when saving state to storage (Hydration)
  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  // Function to convert the state to JSON when saving state to storage (Hydration)
  @override
  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
