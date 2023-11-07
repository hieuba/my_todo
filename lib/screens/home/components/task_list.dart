import 'package:flutter/material.dart';
import 'package:my_todo/models/task_model.dart';
import 'package:my_todo/screens/home/components/task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.taskList,
    required this.type,
  });

  final List<TaskModel> taskList;
  final String type;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return taskTile(
          textTheme: textTheme,
          task: taskList[index],
          context: context,
          index: index,
          type: type,
        );
      },
    );
  }
}
