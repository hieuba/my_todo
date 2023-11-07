import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

Widget buildTextField({
  void Function(String)? func,
  required String hintText,
  required Size size,
  required TextTheme textTheme,
  required BuildContext context,
  required String type,
}) {
  var color = Theme.of(context).brightness == Brightness.light;
  return Container(
    height: 48.h,
    width: size.width,
    decoration: BoxDecoration(
      border: Border.all(
        color: BGREY_COLOR,
      ),
      borderRadius: BorderRadius.circular(APP_BODER_RADIUS),
    ),
    child: SizedBox(
      height: size.height,
      width: size.width,
      child: TextField(
        textInputAction: TextInputAction.done,
        onChanged: (value) => func!(value),
        keyboardType: TextInputType.multiline,
        autocorrect: false,
        obscureText: type == 'password' ? true : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.clear,
              color: color ? BLACK_COLOR : GRAY_COLOR,
            ),
          ),
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
              color: Colors.transparent,
            ),
          ),
          hintStyle: textTheme.titleSmall!.copyWith(
            color: color ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
      ),
    ),
  );
}
