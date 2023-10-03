import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget reusableText({required String text, required TextTheme textTheme}) {
  return Text(
    tr(text),
    style: textTheme.titleSmall,
  );
}
