// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_todo/models/task_model.dart';
import 'package:my_todo/screens/home/task/bloc/task_bloc.dart';
import 'package:my_todo/screens/home/task_detail/task_detail.dart';
import 'package:my_todo/utils/app_color.dart';

Widget taskTile({
  required TextTheme textTheme,
  required TaskModel task,
  required BuildContext context,
  required index,
  required String type,
}) {
  var color = Theme.of(context).brightness == Brightness.light;

  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    decoration: BoxDecoration(
        color: color ? GREY1_COLOR : TASK_COLOR,
        borderRadius: BorderRadius.circular(APP_BODER_RADIUS)),
    height: 72.h,
    width: double.infinity,
    child: Row(
      children: [
        // checkbox
        Container(
          margin: const EdgeInsets.all(10),
          child: customRoundCheckbox(
            context: context,
            isChecked: task.isCompeleted as bool,
            onTap: task.isDeleted == false
                ? () {
                    context.read<TaskBloc>().add(
                          UpdateTask(task: task),
                        );
                  }
                : () {}, // Không cho phép nhấp nếu task.isDeleted là true
          ),
        ),
        // info task
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskDetail(
                    task: task,
                    index: index,
                    type: type,
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    task.title,
                    style: textTheme.titleSmall!.copyWith(
                        decoration: task.isCompeleted!
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                  Row(
                    children: [
                      Text(task.date, style: textTheme.titleMedium),
                      const Spacer(),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.amber,
                      //       borderRadius:
                      //           BorderRadius.circular(APP_BODER_RADIUS)),
                      //   height: 37.h,
                      //   child: Center(
                      //       child: Padding(
                      //     padding: EdgeInsets.symmetric(horizontal: 16.w),
                      //     child: Row(
                      //       children: [
                      //         Container(
                      //           height: 24.h,
                      //           width: 24.w,
                      //           color: Colors.purple,
                      //         ),
                      //         SizedBox(width: 5.w),
                      //         Text(
                      //           '123',
                      //           style: textTheme.titleSmall!.copyWith(
                      //               fontSize: 12.sp,
                      //               fontWeight: FontWeight.w400),
                      //         ),
                      //       ],
                      //     ),
                      //   )),
                      // ),
                      SizedBox(width: 15.w),
                      Container(
                        height: 29.h,
                        width: 42.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: PRIMARY_COLOR),
                          borderRadius: BorderRadius.circular(APP_BODER_RADIUS),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 15.h,
                              width: 15.w,
                              child: SvgPicture.asset(
                                'assets/svgs/flag.svg',
                                fit: BoxFit.cover,
                                color: color ? BLACK_COLOR : GRAY_COLOR,
                              ),
                            ),
                            Text('${index + 1}'),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget customRoundCheckbox({
  required bool isChecked,
  required VoidCallback onTap,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap, // Bắt sự kiện khi người dùng nhấp vào
    child: Container(
      width: 24.w, // Điều chỉnh kích thước hình tròn
      height: 24.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Đặt hình dáng thành hình tròn
        border: Border.all(
          color: PRIMARY_COLOR, // Điều chỉnh màu sắc
          width: 2.0.w,
        ),
      ),
      child: isChecked
          ? const Icon(
              Icons.check, // Hiển thị biểu tượng check nếu isChecked là true
              color: PRIMARY_COLOR,
              size: 18,
            )
          : null, // Không có biểu tượng check nếu isChecked là false
    ),
  );
}
