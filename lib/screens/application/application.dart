// ignore_for_file: prefer_final_fields, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:my_todo/components/textfield/text_field_custom.dart';
import 'package:my_todo/components/widgets/flutter_toast.dart';
import 'package:my_todo/models/task_model.dart';
import 'package:my_todo/screens/application/bloc/application_bloc.dart';
import 'package:my_todo/screens/application/bloc/application_event.dart';
import 'package:my_todo/screens/application/bloc/application_state.dart';
import 'package:my_todo/screens/application/components/build_page.dart';
import 'package:my_todo/screens/home/components/guid.dart';
import 'package:my_todo/screens/home/task/bloc/task_bloc.dart';
import 'package:my_todo/utils/app_color.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  DateTime dateTime = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).brightness == Brightness.light;
    final iconColor = color ? BLACK_COLOR : WHITE_COLOR;
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        return Scaffold(
          body: buildPage(state.index),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor:
                  Colors.transparent, // Set splash color to transparent
              highlightColor:
                  Colors.transparent, // Set highlight color to transparent
            ),
            child: BottomNavigationBar(
              elevation: 0,
              selectedItemColor: iconColor,
              unselectedItemColor: iconColor,
              selectedFontSize: 12.sp,
              unselectedFontSize: 12.sp,
              backgroundColor:
                  color ? Colors.grey.shade200 : const Color(0XFF363636),
              type: BottomNavigationBarType.fixed,
              currentIndex: state.index,
              onTap: (value) {
                if (value != 2) {
                  context.read<ApplicationBloc>().add(TriggerAppEvent(value));
                }
              },
              items: bottomBar(context, iconColor),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showModalBottomSheet();
            },
            child: const Icon(
              Icons.add,
              color: WHITE_COLOR,
            ),
          ),
        );
      },
    );
  }

  // method showModalBottomSheet
  void _showModalBottomSheet() {
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

        return _bottomSheet(mediaQueryData, textTheme, size, context);
      },
    );
  }

  // showModalBottomSheet
  Widget _bottomSheet(
    MediaQueryData mediaQueryData,
    TextTheme textTheme,
    Size size,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      padding: mediaQueryData.viewInsets,
      child: Container(
        padding: EdgeInsets.only(left: H_PADDING, right: H_PADDING, top: 25.h),

        height: 228.h, // Set the desired height
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: textTheme.displayMedium,
              ),
              SizedBox(height: 14.h),
              textField('Enter new task', size, _titleController),
              SizedBox(height: 14.h),
              textField('Description', size, _descriptionController),
              SizedBox(height: 14.h),
              Row(
                children: [
                  _buildIcon(
                    iconPath: 'assets/svgs/timer.svg',
                    onTap: () => _pickDateTime(context),
                  ),
                  SizedBox(width: 32.w),
                  // _buildIcon(
                  //   iconPath: 'assets/svgs/tag.svg',
                  //   onTap: () {},
                  // ),
                  SizedBox(width: 32.w),
                  const Spacer(),
                  _buildIcon(
                    iconPath: 'assets/svgs/send.svg',
                    type: 'send',
                    onTap: () {
                      var task = TaskModel(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        id: GUIDGen.generate(),
                        date: dateTime.toString(),
                        index: '',
                      );
                      context.read<TaskBloc>().add(AddTask(task: task));
                      Navigator.of(context).pop();
                      toastInfo(message: 'Thêm Task thành công!');
                      _titleController.clear();
                      _descriptionController.clear();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon({
    required String iconPath,
    String? type,
    required VoidCallback onTap,
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
          color: type == 'send'
              ? PRIMARY_COLOR
              : color
                  ? BLACK_COLOR
                  : GRAY_COLOR,
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
