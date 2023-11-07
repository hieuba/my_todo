// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:my_todo/screens/home/components/build_appbar.dart';
import 'package:my_todo/screens/home/components/compeleted_task.dart';
import 'package:my_todo/screens/home/components/pending_task.dart';
import 'package:my_todo/screens/home/components/search_box.dart';
import 'package:my_todo/screens/home/task/bloc/task_bloc.dart';
import 'package:my_todo/utils/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? image = '';
  bool isLoading = false;

  @override
  void initState() {
    _getAvatarFromFirebase();
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.sizeOf(context);
    var color = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: H_PADDING),
          child: Column(
            children: [
              buildAppBar(size, textTheme, context, image, isLoading),
              _buildSearch(textTheme),
              TabBar(
                indicatorPadding: EdgeInsets.symmetric(horizontal: 25.w),
                controller: _tabController,
                indicatorColor: PRIMARY_COLOR,
                labelColor: color ? BLACK_COLOR : GRAY_COLOR,
                labelStyle: textTheme.titleMedium,
                tabs: [
                  Tab(
                    text: tr('tabs.pending'),
                    height: 50,
                  ),
                  Tab(
                    text: tr('tabs.compeleted'),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    pendingTask(context),
                    compeletedTask(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearch(TextTheme textTheme) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showSearch(
              context: context,
              delegate: CustomSearch(taskData: [
                ...state.pendingTasks,
                ...state.compeletedTasks,
              ], textTheme: textTheme),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 10.h),
            height: 50.h,
            decoration: BoxDecoration(
              border: Border.all(color: PRIMARY_COLOR),
              borderRadius: BorderRadius.circular(APP_BODER_RADIUS),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: SvgPicture.asset(
                    'assets/svgs/search-normal.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Search for your task...',
                  style: textTheme.titleSmall!.copyWith(color: HINT_COLOR),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future _getAvatarFromFirebase() async {
    setState(() {
      isLoading = true; // Bắt đầu hiển thị vòng quay chờ
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        setState(() {
          image = value.data()!['avatar'];
          isLoading = false;
        });
      }
    });
  }
}
