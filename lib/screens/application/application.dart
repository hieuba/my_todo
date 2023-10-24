import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/screens/application/bloc/application_bloc.dart';
import 'package:my_todo/screens/application/bloc/application_event.dart';
import 'package:my_todo/screens/application/bloc/application_state.dart';
import 'package:my_todo/screens/application/components/build_page.dart';
import 'package:my_todo/utils/app_color.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.sizeOf(context);
    // ignore: no_leading_underscores_for_local_identifiers
    final iconColor = Theme.of(context).brightness == Brightness.light
        ? BLACK_COLOR
        : WHITE_COLOR;
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        return Scaffold(
          body: buildPage(state.index),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor:
                  Colors.transparent, // Set splash color to transparent
              highlightColor:
                  Colors.transparent, // Set highlight color to transparent
            ),
            child: BottomNavigationBar(
              elevation: 0,
              selectedItemColor: iconColor,
              unselectedItemColor: iconColor,
              selectedFontSize: 12.sp,
              unselectedFontSize: 12.sp,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade200
                  : const Color(0XFF363636),
              type: BottomNavigationBarType.fixed,
              currentIndex: state.index,
              onTap: (value) {
                if (value != 2) {
                  context.read<ApplicationBloc>().add(TriggerAppEvent(value));
                }
              },
              items: bottomBar(context, iconColor),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showModalBottomSheet();
            },
            child: const Icon(
              Icons.add,
              color: WHITE_COLOR,
            ),
          ),
        );
      },
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Set to true to make the sheet take up the entire screen height
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            height: 200.0, // Set the desired height
            child: Column(
              children: [
                const Text('ModalBottomSheet Content'),
                TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Enter something',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Do something with the text input
                    print(_textController.text);
                    // Close the ModalBottomSheet
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

/*
  void _showModalBottomSheet(TextTheme textTheme, Size size) {
    showModalBottomSheet(
      backgroundColor: Colors.amber.shade100,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              //  Container(
              //   height: 228.h,
              //   child: Column(
              //     children: [
              //       Text(
              //         'Add Task',
              //         style: textTheme.displayMedium,
              //       ),
              //       SizedBox(height: 14.h),
              //       _textField((value) {}, '', size)
              //     ],
              //   ),
              // ),
              Column(
            children: [
              TextFormField(
                controller: _textController,
                focusNode: _focusNode,
                decoration: InputDecoration(labelText: 'Enter something'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Do something with the text input
                  print(_textController.text);
                  // Close the ModalBottomSheet
                  Navigator.of(context).pop();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
    // Set focus to the text input when the ModalBottomSheet is shown
    _focusNode.requestFocus();
  }
*/
  Widget _textField(void Function(String)? func, String hintText, Size size) {
    return Container(
      height: size.height * .07,
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffA8B2BD)),
        borderRadius: BorderRadius.circular(6.w),
        color: Colors.amber,
      ),
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: TextField(
          controller: _textController,
          textInputAction: TextInputAction.done,
          onChanged: (value) => func!(value),
          keyboardType: TextInputType.multiline,
          autocorrect: false,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.clear,
              ),
            ),
            hintText: hintText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            hintStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xffBABABA),
            ),
          ),
        ),
      ),
    );
  }
}
