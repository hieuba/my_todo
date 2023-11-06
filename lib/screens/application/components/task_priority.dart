import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

class TaskPriority extends StatefulWidget {
  const TaskPriority({super.key});

  @override
  State<TaskPriority> createState() => _TaskPriorityState();
}

class _TaskPriorityState extends State<TaskPriority> {
  List<bool> isCheckColorList = List.generate(10, (index) => false);
  int lastSelectedIndex = -1;

  @override
  void initState() {
    super.initState();

    // Mặc định chọn item đầu tiên
    isCheckColorList[0] = true;
    lastSelectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var checkColor = Theme.of(context).brightness == Brightness.light;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: H_PADDING),
      child: SizedBox(
        height: 380.h,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 11.h),
          child: Column(
            children: [
              Text(
                'Task Priority',
                style:
                    textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
              ),
              const Divider(
                thickness: 2,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (lastSelectedIndex != -1) {
                            isCheckColorList[lastSelectedIndex] = false;
                          }
                          // Cập nhật trạng thái của item hiện tại và lastSelectedIndex
                          isCheckColorList[index] = true;
                          lastSelectedIndex = index;
                        });
                        print('index: ${index + 1}');
                      },
                      child: Container(
                        width: 64.w,
                        height: 64.h,
                        decoration: BoxDecoration(
                          color: isCheckColorList[index]
                              ? PRIMARY_COLOR
                              : (checkColor ? GREY1_COLOR : TASK_COLOR),
                          borderRadius: BorderRadius.circular(
                            APP_BODER_RADIUS,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 5.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/flag.png',
                              color: checkColor ? BLACK_COLOR : WHITE_COLOR,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              '${index + 1}',
                              style: textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 10, // Tổng số items
                ),
              ),
              SizedBox(
                height: 48.h,
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                          child: Text(
                        'Cancel',
                        style: textTheme.titleSmall!
                            .copyWith(color: PRIMARY_COLOR),
                      )),
                    )),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                              color: PRIMARY_COLOR,
                              borderRadius:
                                  BorderRadius.circular(APP_BODER_RADIUS)),
                          child: Center(
                            child: Text(
                              'Save',
                              style: textTheme.titleSmall!
                                  .copyWith(color: WHITE_COLOR),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
