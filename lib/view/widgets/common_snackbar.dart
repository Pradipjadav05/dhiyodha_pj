import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String? message, {bool isError = true}) {
  if (message == null || message.isEmpty) return;

  final context = Get.context;

  if (context == null) return;

  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor:
      isError ? Colors.redAccent : Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    ),
  );
}