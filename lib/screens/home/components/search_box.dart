// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_todo/models/task_model.dart';
import 'package:my_todo/screens/home/components/task_tile.dart';
import 'package:my_todo/screens/home/task_detail/task_detail.dart';
import 'package:my_todo/utils/app_color.dart';

class CustomSearch extends SearchDelegate {
  List<TaskModel> taskData;
  TextTheme textTheme;

  CustomSearch({
    required this.taskData,
    required this.textTheme,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    var color = Theme.of(context).brightness == Brightness.light;
    List<TaskModel> matchQuery = [];
    for (var item in taskData) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: H_PADDING),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskDetail(
                    task: result,
                    index: index,
                    type: 'pending',
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                  color: color ? GREY1_COLOR : TASK_COLOR,
                  borderRadius: BorderRadius.circular(APP_BODER_RADIUS)),
              height: 72.h,
              width: double.infinity,
              child: Row(
                children: [
                  // checkbox
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: customRoundCheckbox(
                      context: context,
                      isChecked: result.isCompeleted as bool,
                      onTap:
                          () {}, // Không cho phép nhấp nếu task.isDeleted là true
                    ),
                  ),
                  // info task
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            result.title,
                            style: textTheme.titleSmall!.copyWith(
                                decoration: result.isCompeleted!
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          Row(
                            children: [
                              Text(result.date, style: textTheme.titleMedium),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(
                                        APP_BODER_RADIUS)),
                                height: 37.h,
                                child: Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 24.h,
                                        width: 24.w,
                                        color: Colors.purple,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        '123',
                                        style: textTheme.titleSmall!.copyWith(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                              SizedBox(width: 15.w),
                              Container(
                                height: 29.h,
                                width: 42.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: PRIMARY_COLOR),
                                  borderRadius:
                                      BorderRadius.circular(APP_BODER_RADIUS),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                      width: 15.w,
                                      child: SvgPicture.asset(
                                        'assets/svgs/flag.svg',
                                        fit: BoxFit.cover,
                                        color: color ? BLACK_COLOR : GRAY_COLOR,
                                      ),
                                    ),
                                    Text('${index + 1}'),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var color = Theme.of(context).brightness == Brightness.light;
    List<TaskModel> matchQuery = [];
    for (var item in taskData) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: H_PADDING,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskDetail(
                    task: result,
                    index: index,
                    type: 'pending',
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 15.h),
              decoration: BoxDecoration(
                  color: color ? GREY1_COLOR : TASK_COLOR,
                  borderRadius: BorderRadius.circular(APP_BODER_RADIUS)),
              height: 72.h,
              width: double.infinity,
              child: Row(
                children: [
                  // checkbox
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: customRoundCheckbox(
                      context: context,
                      isChecked: result.isCompeleted as bool,
                      onTap:
                          () {}, // Không cho phép nhấp nếu task.isDeleted là true
                    ),
                  ),
                  // info task
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            result.title,
                            style: textTheme.titleSmall!.copyWith(
                                decoration: result.isCompeleted!
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          Row(
                            children: [
                              Text(result.date, style: textTheme.titleMedium),
                              const Spacer(),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       color: Colors.amber,
                              //       borderRadius: BorderRadius.circular(
                              //           APP_BODER_RADIUS)),
                              //   height: 37.h,
                              //   child: Center(
                              //       child: Padding(
                              //     padding:
                              //         EdgeInsets.symmetric(horizontal: 16.w),
                              //     child: Row(
                              //       children: [
                              //         Container(
                              //           height: 24.h,
                              //           width: 24.w,
                              //           color: Colors.purple,
                              //         ),
                              //         SizedBox(width: 5.w),
                              //         Text(
                              //           '123',
                              //           style: textTheme.titleSmall!.copyWith(
                              //               fontSize: 12.sp,
                              //               fontWeight: FontWeight.w400),
                              //         ),
                              //       ],
                              //     ),
                              //   )),
                              // ),
                              SizedBox(width: 15.w),
                              Container(
                                height: 29.h,
                                width: 42.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: PRIMARY_COLOR),
                                  borderRadius:
                                      BorderRadius.circular(APP_BODER_RADIUS),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                      width: 15.w,
                                      child: SvgPicture.asset(
                                        'assets/svgs/flag.svg',
                                        fit: BoxFit.cover,
                                        color: color ? BLACK_COLOR : GRAY_COLOR,
                                      ),
                                    ),
                                    Text('${index + 1}'),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
