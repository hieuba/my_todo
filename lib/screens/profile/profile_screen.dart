// ignore_for_file: avoid_print, unused_field, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_todo/components/dialog/dialog_custom.dart';
import 'package:my_todo/global.dart';
import 'package:my_todo/routes/routes.dart';
import 'package:my_todo/screens/application/bloc/application_bloc.dart';
import 'package:my_todo/screens/application/bloc/application_event.dart';
import 'package:my_todo/screens/home/task/bloc/task_bloc.dart';
import 'package:my_todo/screens/profile/components/build_item.dart';
import 'package:my_todo/screens/profile/components/reuse_text.dart';
import 'package:my_todo/screens/profile/components/select_photo.dart';
import 'package:my_todo/utils/app_color.dart';
import 'package:my_todo/utils/constans.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  var db = FirebaseFirestore.instance;
  String? image = '';
  bool isLoading = false;

  Future pickImage(ImageSource source) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }

      File? img = File(image.path);

      img = await _cropImage(imageFile: img);

      // Gọi phương thức cập nhật avatar cho người dùng đã đăng nhập
      await updateAvatarForLoggedInUser(img!);

      setState(() {
        _image = img;
        // Update the avatar image immediately when it's picked
        // Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future updateAvatarForLoggedInUser(File img) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      print('user: $user');
      if (user != null) {
        // Use the user's UID as part of the filename
        final String userId = user.uid;
        final storageReference = FirebaseStorage.instance.ref().child(
            'avatars/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg');

        await storageReference.putFile(img);

        // Get the download URL once the upload is complete
        final avatarUrl = await storageReference.getDownloadURL();

        // context.read<AvatarBloc>().updateAvatar(img);

        // Cập nhật avatarUrl vào Firestore
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .update({
          "avatar": avatarUrl,
        });
        // Set state to update the UI immediately
        setState(() {
          image = avatarUrl;
        });
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future _getAvatarFromFirebase() async {
    setState(() {
      isLoading = true; // Bắt đầu hiển thị vòng quay chờ
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        setState(() {
          image = value.data()!['avatar'];
          isLoading = false; // Kết thúc hiển thị vòng quay chờ khi hoàn thành
        });
      }
    });
  }

  @override
  void initState() {
    _getAvatarFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    User? user = FirebaseAuth.instance.currentUser;
    String? displayGmail = user != null ? (user.email) : 'loi';
    var color = Theme.of(context).brightness == Brightness.light;

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
                    tr('profile.title'),
                    style: textTheme.titleSmall,
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {},
                    child: isLoading
                        ? SizedBox(
                            height: 80.h,
                            width: 80.w,
                            child: const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          )
                        : Container(
                            height: 80.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: PRIMARY_COLOR,
                              image: image == null || image == ''
                                  ? const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/check_list.png'),
                                    )
                                  : DecorationImage(
                                      image: NetworkImage(image!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    displayGmail!,
                    style: textTheme.titleSmall,
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
                              color: color ? GREY1_COLOR : TASK_COLOR,
                              borderRadius:
                                  BorderRadius.circular(APP_BODER_RADIUS)),
                          child: Center(
                            child: Text(
                              '${context.read<TaskBloc>().state.pendingTasks.length.toString()} Task left',
                              style: textTheme.titleSmall,
                            ),
                          ),
                        ),
                        Container(
                          height: 58.h,
                          width: size.width * .4,
                          color: color ? GREY1_COLOR : TASK_COLOR,
                          child: Center(
                            child: Text(
                              '${context.read<TaskBloc>().state.compeletedTasks.length.toString()} Task done',
                              style: textTheme.titleSmall,
                            ),
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
              iconPath: 'assets/svgs/setting-2.svg',
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
              iconPath: 'assets/svgs/key.svg',
              onTap: () {},
            ),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'profile.changeimage',
              iconPath: 'assets/svgs/camera.svg',
              onTap: () {
                _showSelectPhotoOptions(context);
              },
            ),
            // ------
            reusableText(text: 'UpTodo', textTheme: textTheme),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'About US',
              iconPath: 'assets/svgs/menu.svg',
              onTap: () {},
            ),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'FAQ',
              iconPath: 'assets/svgs/info-circle.svg',
              onTap: () {},
            ),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'Help & Feedback',
              iconPath: 'assets/svgs/flash.svg',
              onTap: () {},
            ),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'Support US',
              iconPath: 'assets/svgs/like.svg',
              onTap: () {},
            ),
            buildItem(
              context: context,
              size: size,
              textTheme: textTheme,
              text: 'profile.logout',
              iconPath: 'assets/svgs/logout.svg',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogCustom(
                      cancle: () {
                        Navigator.of(context).pop();
                      },
                      content: 'Do you want to log out?',
                      done: removeUserData,
                      title: 'Notification',
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

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        child: SelectPhotoOptionsScreen(
          onTap: pickImage,
        ),
      ),
    );
  }
}
