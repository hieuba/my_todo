// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_todo/components/dialog/dialog_custom.dart';
import 'package:my_todo/components/format_datetime/format_datetime.dart';
import 'package:my_todo/components/textfield/text_field_custom.dart';
import 'package:my_todo/models/task_model.dart';
import 'package:my_todo/screens/home/task/bloc/task_bloc.dart';
import 'package:my_todo/utils/app_color.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({
    super.key,
    required this.task,
    required this.index,
    required this.type,
  });

  final TaskModel task;
  final int index;
  final String type;

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            _buildBody(
              textTheme,
              context,
              widget.task,
              widget.index,
              widget.type,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    TextTheme textTheme,
    BuildContext context,
    TaskModel task,
    int index,
    String type,
  ) {
    var size = MediaQuery.sizeOf(context);
    var color = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: H_PADDING),
      child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            // title and description
            _buildInfoTask(textTheme, color, task, type),
            // time
            _buildItem(
              textTheme: textTheme,
              context: context,
              iconPath: 'assets/svgs/timer.svg',
              title: 'Task Time :',
              value: task.date,
            ),
            // category
            // _buildItem(
            //     textTheme: textTheme,
            //     context: context,
            //     iconPath: 'assets/svgs/tag.svg',
            //     title: 'Task Category :',
            //     value: 'University',
            //     type: 'category'),
            // index
            _buildItem(
              textTheme: textTheme,
              context: context,
              iconPath: 'assets/svgs/flag.svg',
              title: 'Task Index :',
              value: '${index + 1}',
            ),
            // detele btn
            _deteteTask(textTheme, context, task),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTask(
    TextTheme textTheme,
    bool color,
    TaskModel task,
    String type,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      height: 65.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _customRoundCheckbox(),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    decoration: type == 'pending'
                        ? TextDecoration.none
                        : TextDecoration.lineThrough),
              ),
              Text(task.description, style: textTheme.titleSmall),
            ],
          ),
          const Spacer(),
          //////
          type == 'pending'
              ? GestureDetector(
                  onTap: () {
                    _showModalBottomSheet(context, task);
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: 24.h,
                    width: 24.w,
                    child: SvgPicture.asset(
                      'assets/svgs/edit-2.svg',
                      fit: BoxFit.cover,
                      color: color ? BLACK_COLOR : WHITE_COLOR,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  // method showModalBottomSheet
  void _showModalBottomSheet(BuildContext context, TaskModel oldTask) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Set to true to make the sheet take up the entire screen height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        final MediaQueryData mediaQueryData = MediaQuery.of(context);
        final textTheme = Theme.of(context).textTheme;
        final size = MediaQuery.sizeOf(context);

        return _bottomSheet(mediaQueryData, textTheme, size, context, oldTask);
      },
    );
  }

  Widget _bottomSheet(MediaQueryData mediaQueryData, TextTheme textTheme,
      Size size, BuildContext context, TaskModel oldTask) {
    TextEditingController _titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController _descriptionController =
        TextEditingController(text: oldTask.description);

    return SingleChildScrollView(
      padding: mediaQueryData.viewInsets,
      child: Container(
        padding: EdgeInsets.only(left: H_PADDING, right: H_PADDING, top: 25.h),

        height: 250.h, // Set the desired height
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Task',
                style: textTheme.displayMedium,
              ),
              SizedBox(height: 14.h),
              textField('Title', size, _titleController),
              SizedBox(height: 14.h),
              textField('Description', size, _descriptionController),
              SizedBox(height: 14.h),
              Row(
                children: [
                  _buildIcon(
                      iconPath: 'assets/svgs/timer.svg',
                      onTap: () => _pickDateTime(context),
                      context: context),
                  SizedBox(width: 32.w),
                  // _buildIcon(
                  //     iconPath: 'assets/svgs/tag.svg',
                  //     onTap: () {},
                  //     context: context),
                  SizedBox(width: 32.w),
                  const Spacer(),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            tr("edit.cancle"),
                            style: textTheme.titleMedium!
                                .copyWith(color: PRIMARY_COLOR),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: PRIMARY_COLOR),
                          onPressed: () {
                            var editTask = TaskModel(
                              id: oldTask.id,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              date: dateTime.toString(),
                              isCompeleted: false,
                              index: '',
                            );
                            context.read<TaskBloc>().add(
                                  EditTask(
                                    oldTask: oldTask,
                                    newTask: editTask,
                                  ),
                                );
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text(tr("edit.save"))),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // pick DateTime
  Future _pickDateTime(BuildContext context) async {
    DateTime? date = await _pickDate();
    if (date == null) return;

    TimeOfDay? time = await _pickTime();
    if (time == null) return;

    final newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      dateTime = newDateTime;
    });
  }

  Future<DateTime?> _pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030));

  Future<TimeOfDay?> _pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );
}

Widget _customRoundCheckbox() {
  return Container(
    width: 24.w, // Điều chỉnh kích thước hình tròn
    height: 24.h,
    decoration: BoxDecoration(
      shape: BoxShape.circle, // Đặt hình dáng thành hình tròn
      border: Border.all(
        color: PRIMARY_COLOR, // Điều chỉnh màu sắc
        width: 2.0.w,
      ),
    ),
  );
}

Widget _buildItem({
  required TextTheme textTheme,
  required BuildContext context,
  required String iconPath,
  required String title,
  required String value,
  String? type,
}) {
  var color = Theme.of(context).brightness == Brightness.light;
  return Container(
    margin: EdgeInsets.only(bottom: 30.h),
    height: 37.h,
    child: Row(
      children: [
        SizedBox(
          height: 24.h,
          width: 24.w,
          child: SvgPicture.asset(
            iconPath,
            color: color ? BLACK_COLOR : WHITE_COLOR,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: textTheme.titleSmall,
        ),
        const Spacer(),
        Container(
          color: color ? GREY1_COLOR : TASK_COLOR,
          height: 37.h,
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: type == 'category'
                ? Row(
                    children: [
                      Container(
                        height: 24.h,
                        width: 24.w,
                        color: Colors.amber,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          value,
                          style: textTheme.titleSmall!.copyWith(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  )
                : Text(
                    value,
                    style: textTheme.titleSmall!
                        .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
          )),
        ),
      ],
    ),
  );
}

Widget _deteteTask(
  TextTheme textTheme,
  BuildContext context,
  TaskModel task,
) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return DialogCustom(
              done: () {
                context.read<TaskBloc>().add(DeleteTask(task: task));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              cancle: () {
                Navigator.of(context).pop();
              },
              title: 'Thông báo',
              content:
                  'Bạn có muốn xoá Task không?\nTask Title: ${task.title}');
        },
      );
    },
    child: Container(
      color: Colors.transparent,
      height: 24.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 24.h,
            width: 24.w,
            child: SvgPicture.asset(
              'assets/svgs/trash.svg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 11.w),
          Text(
            'Delete Task',
            style: textTheme.titleSmall!.copyWith(color: ERROR_COLOR),
          )
        ],
      ),
    ),
  );
}

Widget _buildAppBar(BuildContext context) {
  var color = Theme.of(context).brightness == Brightness.light;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: H_PADDING),
    child: SizedBox(
      height: 42.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration:
                  BoxDecoration(color: color ? GREY1_COLOR : TASK_COLOR),
              height: 32.h,
              width: 32.w,
              child: SvgPicture.asset(
                'assets/svgs/add.svg',
                fit: BoxFit.cover,
                color: color ? BLACK_COLOR : WHITE_COLOR,
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(color: color ? GREY1_COLOR : TASK_COLOR),
          //   height: 32.h,
          //   width: 32.w,
          //   child: SvgPicture.asset(
          //     'assets/svgs/repeat.svg',
          //     fit: BoxFit.cover,
          //     color: color ? BLACK_COLOR : WHITE_COLOR,
          //   ),
          // )
        ],
      ),
    ),
  );
}

Widget _buildIcon({
  required String iconPath,
  required VoidCallback onTap,
  required BuildContext context,
}) {
  var color = Theme.of(context).brightness == Brightness.light;
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      height: 24.h,
      width: 24.w,
      child: SvgPicture.asset(
        iconPath,
        fit: BoxFit.cover,
        color: color ? BLACK_COLOR : GRAY_COLOR,
      ),
    ),
  );
}
