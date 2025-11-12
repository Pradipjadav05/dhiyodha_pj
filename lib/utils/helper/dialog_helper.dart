import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  String title = "";
  String message = "";
  String positiveButtonText = "";
  String negativeButtonText = "";
  bool isShowIcon = false;
  String icon = "";
  Function onPositiveClick = () {};
  Function onNegativeClick = () {};

  DialogHelper(
      {required this.title,
      required this.message,
      required this.positiveButtonText,
      required this.negativeButtonText,
      required this.isShowIcon,
      required this.icon,
      required this.onPositiveClick,
      required this.onNegativeClick});

  Future<void> showCommonDialog(BuildContext buildContext) async {
    return showDialog(
      context: buildContext,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            child: Container(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        isShowIcon
                            ? Image.asset(
                                icon,
                                height: iconSize22,
                                width: iconSize22,
                              )
                            : Container(),
                        isShowIcon
                            ? const SizedBox(width: paddingSize14)
                            : const SizedBox(width: 0),
                        Text(
                          title.tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: paddingSize25,
                    ),
                    Text(message.tr,
                        style: fontMedium.copyWith(
                            color: midnightBlue, fontSize: fontSize14)),
                    SizedBox(
                      height: paddingSize25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(paddingSize15),
                          child: InkWell(
                            child: Text(negativeButtonText.tr,
                                style: fontMedium.copyWith(
                                    color: greyText, fontSize: fontSize14)),
                            onTap: () => onNegativeClick,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(paddingSize15),
                          child: InkWell(
                            child: Text(positiveButtonText.tr,
                                style: fontBold.copyWith(
                                    color: midnightBlue, fontSize: fontSize14)),
                            onTap: () => onPositiveClick,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
