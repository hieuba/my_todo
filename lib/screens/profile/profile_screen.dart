import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // top content
              Container(
                height: 250.h,
                width: size.width,
                color: Colors.blue.shade200,
              ),
              // column items
              _reusableText(text: 'Settings', textTheme: textTheme),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _reusableText({
  required String text,
  required TextTheme textTheme,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: H_PADDING),
    child: Text(
      text,
      style: textTheme.titleMedium,
    ),
  );
}

Widget _buildItem({
  required Size size,
  required TextTheme textTheme,
  required String text,
  required IconData icon,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: H_PADDING),
    child: Container(
      height: 48.h,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.purple.shade200,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.settings),
          SizedBox(width: 10.h),
          Text(
            'settings',
            style: textTheme.titleMedium,
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}
