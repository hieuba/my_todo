// ignore_for_file: avoid_print, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_todo/global.dart';
import 'package:my_todo/routes/routes.dart';
import 'package:my_todo/screens/application/bloc/application_bloc.dart';
import 'package:my_todo/screens/application/bloc/application_event.dart';
import 'package:my_todo/screens/profile/components/build_item.dart';
import 'package:my_todo/screens/profile/components/reuse_text.dart';
import 'package:my_todo/screens/profile/user/bloc/user_bloc.dart';
import 'package:my_todo/utils/app_color.dart';
import 'package:my_todo/utils/constans.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

  // Future _pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //     File? img = File(image.path);
  //     img = await _cropImage(imageFile: img);
  //     setState(() {
  //       _image = img;
  //     });
  //   } on PlatformException catch (e) {
  //     print('exception: $e');
  //   }
  // }
  Future _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) return;

      // await _cropImage(imageFile: File(image.path));
      return image.path;
    } on PlatformException catch (e) {
      print('exception: $e');
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    var avatarCubit = context.read<AvatarCubit>();
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // top content
            SizedBox(
              height: 240.h,
              width: size.width,
              // color: Colors.blue.shade200,
              child: Column(
                children: [
                  Text(
                    'Profile',
                    style: textTheme.titleSmall,
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () async {
                      final imagePath = await _pickImage(ImageSource.gallery);

                      if (imagePath != null) {
                        await _cropImage(imageFile: File(imagePath));
                        avatarCubit.setImage(imagePath);
                      }
                    },
                    child: BlocBuilder<AvatarCubit, AvatarState>(
                      builder: (context, state) {
                        return Container(
                          height: 80.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber.shade100,
                            image: state.imagePath.isEmpty
                                ? const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/check_list.png'),
                                  )
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(context
                                        .watch<AvatarCubit>()
                                        .state
                                        .imagePath)),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.camera);
                    },
                    child: Text(
                      'User name',
                      style: textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: H_PADDING),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 58.h,
                          width: size.width * .4,
                          decoration: BoxDecoration(
                              color: TASK_COLOR,
                              borderRadius:
                                  BorderRadius.circular(APP_BODER_RADIUS)),
                          child: Center(
                            child: Text('10 tash left'),
                          ),
                        ),
                        Container(
                          height: 58.h,
                          width: size.width * .4,
                          color: TASK_COLOR,
                          child: Center(
                            child: Text('5 tash done'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // column items
            reusableText(text: 'profile.settings', textTheme: textTheme),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'profile.settings',
              iconPath: 'assets/icons/setting.png',
              onTap: () {
                Navigator.pushNamed(context, '/setting');
              },
            ),
            // ------
            reusableText(text: 'profile.account', textTheme: textTheme),

            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'profile.changepass',
              iconPath: 'assets/icons/key.png',
              onTap: () {},
            ),
            // ------
            reusableText(text: 'UpTodo', textTheme: textTheme),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'About US',
              iconPath: 'assets/icons/menu.png',
              onTap: () {},
            ),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'FAQ',
              iconPath: 'assets/icons/info-circle.png',
              onTap: () {},
            ),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'Help & Feedback',
              iconPath: 'assets/icons/flash.png',
              onTap: () {},
            ),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'Support US',
              iconPath: 'assets/icons/like.png',
              onTap: () {},
            ),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'profile.logout',
              iconPath: 'assets/icons/logout.png',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('THONG BAO'),
                      content: Text('BAN CO MUON DANG XUAT KHONG'),
                      actions: [
                        TextButton(
                          onPressed: removeUserData,
                          child: Text('yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('no'),
                        ),
                      ],
                    );
                  },
                );
              },
              type: 'logout',
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  void removeUserData() {
    context.read<ApplicationBloc>().add(TriggerAppEvent(0));
    Global.storageService.removeToken(AppConstants.STORAGE_USER_TOKEN_KEY);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.LOG_IN, (route) => false);
  }
}
