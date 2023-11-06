// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_todo/models/task_model.dart';
import 'package:my_todo/screens/home/components/check_list.dart';
import 'package:my_todo/screens/home/components/task_list.dart';
import 'package:my_todo/screens/home/task/bloc/task_bloc.dart';
import 'package:my_todo/utils/app_color.dart';

Widget compeletedTask(BuildContext context) {
  var checkColor = Theme.of(context).brightness == Brightness.light;
  var textTheme = Theme.of(context).textTheme;
  return BlocBuilder<TaskBloc, TaskState>(
    builder: (context, state) {
      List<TaskModel> taskList = state.compeletedTasks;
      print('compeleted List: ${taskList}');
      return taskList.isEmpty
          ? checkList(textTheme: textTheme)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  height: 31.h,
                  width: 76.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: checkColor ? GREY1_COLOR : TASK_COLOR,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Today'),
                      SvgPicture.asset(
                        'assets/svgs/arrow-down.svg',
                        fit: BoxFit.cover,
                        color: checkColor ? BLACK_COLOR : GRAY_COLOR,
                      ),
                    ],
                  ),
                ),
                Expanded(child: TaskList(taskList: taskList)),
              ],
            );
    },
  );
}
