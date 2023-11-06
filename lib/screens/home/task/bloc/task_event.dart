// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'task_bloc.dart';

@immutable
sealed class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

class AddTask extends TaskEvent {
  TaskModel task;

  AddTask({
    required this.task,
  });

  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  TaskModel task;

  UpdateTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  TaskModel task;

  DeleteTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class EditTask extends TaskEvent {
  final TaskModel oldTask;
  final TaskModel newTask;

  const EditTask({
    required this.oldTask,
    required this.newTask,
  });

  @override
  List<Object> get props => [oldTask, newTask];
}
