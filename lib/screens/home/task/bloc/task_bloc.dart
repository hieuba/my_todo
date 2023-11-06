import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_todo/models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<EditTask>(_onEditTask);
  }

  FutureOr<void> _onAddTask(AddTask event, Emitter<TaskState> emit) {
    //  final task = event.task;
    emit(
      TaskState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        compeletedTasks: state.compeletedTasks,
      ),
    );
  }

  FutureOr<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final task = event.task;

    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> compeletedTasks = state.compeletedTasks;

    task.isCompeleted == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            compeletedTasks = List.from(compeletedTasks)
              ..insert(
                0,
                task.copyWith(isCompeleted: true),
              ),
          }
        : {
            compeletedTasks = List.from(compeletedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(
                0,
                task.copyWith(isCompeleted: false),
              ),
          };
    emit(
      TaskState(
        pendingTasks: pendingTasks,
        compeletedTasks: compeletedTasks,
      ),
    );
  }

  FutureOr<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    emit(
      TaskState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        compeletedTasks: List.from(state.compeletedTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)..remove(event.task),
      ),
    );
  }

  FutureOr<void> _onEditTask(EditTask event, Emitter<TaskState> emit) {
    emit(
      TaskState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        compeletedTasks: state.compeletedTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }
}
