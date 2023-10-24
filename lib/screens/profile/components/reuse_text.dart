import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_todo/utils/app_color.dart';

Widget reusableText({
  required String text,
  required TextTheme textTheme,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: H_PADDING),
    child: Text(
      tr(text),
      style: textTheme.titleMedium,
    ),
  );
}
