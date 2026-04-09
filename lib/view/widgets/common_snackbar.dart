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
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isError ? Colors.redAccent : Colors.green,
        ),

          // margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                isError ? Icons.warning_amber : Icons.check_circle_outline,
                color: white,
                size: 22,
              ),
              SizedBox(width: 12),
              Text(message, style: TextStyle(fontSize: fontSize16),),
            ],
          )),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.fixed,
      // margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 3),
    ),
  );
}
