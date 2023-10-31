// ignore_for_file: avoid_print, unused_field, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_todo/global.dart';
import 'package:my_todo/routes/routes.dart';
import 'package:my_todo/screens/application/bloc/application_bloc.dart';
import 'package:my_todo/screens/application/bloc/application_event.dart';
import 'package:my_todo/screens/login/login_controller.dart';
import 'package:my_todo/screens/profile/avatar/cubit/avatar_cubit.dart';
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

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }

      File? img = File(image.path);

      img = await _cropImage(imageFile: img);

      // Gọi phương thức cập nhật avatar cho người dùng đã đăng nhập
      await updateAvatarForLoggedInUser(img!);

      setState(() {
        _image = img;
        Navigator.of(context).pop();
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

        print('avatar::: $avatarUrl');
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
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        setState(() {
          image = value.data()!['avatar'];
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
    print('username: $displayGmail');
    print('avatarUrl: $image');

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
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: PRIMARY_COLOR,
                        image: (image == null || image == '')
                            ? const DecorationImage(
                                image:
                                    AssetImage('assets/images/check_list.png'),
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
                              color: TASK_COLOR,
                              borderRadius:
                                  BorderRadius.circular(APP_BODER_RADIUS)),
                          child: const Center(
                            child: Text('10 tash left'),
                          ),
                        ),
                        Container(
                          height: 58.h,
                          width: size.width * .4,
                          color: TASK_COLOR,
                          child: const Center(
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

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: pickImage,
              ),
            );
          }),
    );
  }
}


  // BlocBuilder<AvatarBloc, File?>(
                    //   builder: (context, avatarFile) {
                    //     return  Container(
                    //       height: 80.h,
                    //       width: 80.w,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.amber,
                    //         image: avatarFile == null
                    //             ? const DecorationImage(
                    //                 image: AssetImage(
                    //                     'assets/images/check_list.png'),
                    //               )
                    //             : DecorationImage(
                    //                 image: FileImage(avatarFile),
                    //                 fit: BoxFit.cover),
                    //       ),
                    //     );
                    //   },
                    // ),
