import 'package:flutter/material.dart';
import 'package:my_todo/components/main_btn.dart';
import 'package:my_todo/components/second_btn.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              secondBtn(size, 'NEXT', textTheme),
              mainBtn(size, 'NEXT', textTheme)
            ],
          ),
        ),
      ),
    );
  }
}
