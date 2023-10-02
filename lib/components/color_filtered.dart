import 'package:flutter/material.dart';
import 'package:my_todo/utils/app_color.dart';

class CustomColorFilteredIcon extends StatelessWidget {
  final String imagePath;
  final bool isLightTheme;

  const CustomColorFilteredIcon({
    super.key,
    required this.imagePath,
    required this.isLightTheme,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = isLightTheme ? BLACK_COLOR : GRAY_COLOR;
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        iconColor,
        BlendMode.srcIn,
      ),
      child: Image.asset(imagePath),
    );
  }
}
