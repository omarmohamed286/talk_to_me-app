import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog customDialog(
        {required BuildContext context,
        required String title,
        required String desc,
        void Function()? onCancel,
        void Function()? onOk}) =>
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnCancelOnPress: onCancel ?? () {},
      btnOkOnPress: onOk,
    );
