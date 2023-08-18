// ignore_for_file: must_be_immutable

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ErrorFlushBar extends Flushbar {
  final String msg;

  ErrorFlushBar(this.msg, {Key? key}) : super(key: key);

  @override
  String? get message => msg;

  @override
  Duration? get duration => const Duration(seconds: 2, milliseconds: 500);

  @override
  Color get backgroundColor => Colors.grey.shade800;

  @override
  Color get messageColor => Colors.white;
  @override
  double get messageSize => 16;

  @override
  Color? get leftBarIndicatorColor => AppColors.red;

  @override
  Widget? get icon => const Icon(
        Icons.info_outline,
        size: 34.0,
        color: AppColors.red,
      );

  @override
  EdgeInsets get margin => const EdgeInsets.all(8);

// @override
// BorderRadius? get borderRadius => BorderRadius.circular(8);
}
