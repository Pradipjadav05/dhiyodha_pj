import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String? message, {bool isError = true}) {
  Get.showSnackbar(GetSnackBar(
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? Colors.red : midnightBlue,
    message: message,
    duration: const Duration(seconds: 7),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(paddingSize10),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}
