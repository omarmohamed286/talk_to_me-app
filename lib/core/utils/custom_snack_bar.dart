import 'package:flutter/material.dart';

void showErrorSnackBar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
    ),
    backgroundColor: Colors.red,
  ));
}