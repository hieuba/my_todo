import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_todo/utils/app_color.dart';

class SelectPhotoOptionsScreen extends StatelessWidget {
  final Function(ImageSource source) onTap;

  const SelectPhotoOptionsScreen({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: H_PADDING, right: H_PADDING, bottom: 24.h),
      child: Column(
        children: [
          SizedBox(
            height: 35.h,
            child: Center(
              child: Container(
                height: 5.h,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          Column(
            children: [
              SelectPhoto(
                onTap: () => onTap(ImageSource.gallery),
                icon: Icons.image,
                textLabel: 'Browse Gallery',
              ),
              SizedBox(
                height: 10.h,
              ),
              SelectPhoto(
                onTap: () => onTap(ImageSource.camera),
                icon: Icons.camera_alt_outlined,
                textLabel: 'Use a Camera',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SelectPhoto extends StatelessWidget {
  final String textLabel;
  final IconData icon;

  final void Function()? onTap;

  const SelectPhoto({
    Key? key,
    required this.textLabel,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(APP_BODER_RADIUS)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon),
                  SizedBox(width: 10.w),
                  Text(
                    textLabel,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
