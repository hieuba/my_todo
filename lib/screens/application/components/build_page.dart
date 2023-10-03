import 'package:flutter/material.dart';

Widget buildPage(int index) {
  List<Widget> _widgets = [
    Center(child: Text('index')),
    Center(child: Text('calendar')),
    Center(child: Text('abc')),
    Center(child: Text('focus')),
    Center(child: Text('profile')),
  ];
  return _widgets[index];
}
