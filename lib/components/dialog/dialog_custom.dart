import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogCustom extends StatelessWidget {
  const DialogCustom({
    super.key,
    required this.done,
    required this.cancle,
    required this.title,
    required this.content,
  });

  final VoidCallback done;
  final VoidCallback cancle;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AlertDialog(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: done,
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: cancle,
            child: const Text(
              'Cancle',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    } else if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: done,
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: cancle,
            child: const Text(
              'Cancle',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
