// ignore_for_file: must_be_immutable

part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<TaskModel> pendingTasks;
  final List<TaskModel> compeletedTasks;
  final List<TaskModel> removedTasks;

  const TaskState({
    this.pendingTasks = const <TaskModel>[],
    this.compeletedTasks = const <TaskModel>[],
    this.removedTasks = const <TaskModel>[],
  });

  @override
  List<Object?> get props => [pendingTasks, compeletedTasks, removedTasks];
}
