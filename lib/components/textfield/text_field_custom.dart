import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

Widget textField(
  String hintText,
  Size size,
  TextEditingController textController,
) {
  return Container(
    height: 50.h,
    width: size.width,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.transparent),
      borderRadius: BorderRadius.circular(6.w),
    ),
    child: SizedBox(
      height: size.height,
      width: size.width,
      child: TextField(
        cursorColor: PRIMARY_COLOR,
        autofocus: true,
        controller: textController,
        keyboardType: TextInputType.multiline,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: PRIMARY_COLOR,
            ),
          ),
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: HINT_COLOR,
          ),
        ),
      ),
    ),
  );
}
