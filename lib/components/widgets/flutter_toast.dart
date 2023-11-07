import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_todo/utils/app_color.dart';

toastInfo({
  required String message,
  Color backgroundColor = BLACK_COLOR,
  Color textColor = WHITE_COLOR,
}) {
  return Fluttertoast.showToast(
    msg: tr(message),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16.sp,
  );
}
