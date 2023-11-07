// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_todo/utils/app_color.dart';

Widget buildAppBar(
  Size size,
  TextTheme textTheme,
  BuildContext context,
  String? image,
  bool isLoading,
) {
  var color = Theme.of(context).brightness == Brightness.light;
  return SizedBox(
    height: 42.h,
    width: size.width,
    child: Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 24.h,
              width: 24.w,
              child: SvgPicture.asset(
                'assets/svgs/sort.svg',
                color: color ? BLACK_COLOR : WHITE_COLOR,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Index',
                style: textTheme.displayMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            isLoading
                ? SizedBox(
                    height: 42.h,
                    width: 42.w,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  )
                : Container(
                    height: 42.h,
                    width: 42.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: image == null || image == ''
                          ? const DecorationImage(
                              image: AssetImage('assets/images/check_list.png'),
                            )
                          : DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
          ],
        ),
      ],
    ),
  );
}
