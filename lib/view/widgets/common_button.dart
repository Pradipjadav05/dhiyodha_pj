import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? bgColor;
  final Color? textColor;
  final Color? iconColor;
  final String? icon;
  final double radius;
  final bool isGradient;

  const CommonButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.width,
      this.height,
      this.fontSize,
      this.bgColor,
      this.iconColor,
      this.textColor,
      this.icon,
      this.isGradient = false,
      this.radius = radius10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : isGradient
              ? Colors.transparent
              : transparent
                  ? Colors.transparent
                  : bgColor ?? Theme.of(context).primaryColor,
      minimumSize:
          Size(width != null ? width! : 1170, height != null ? height! : 45),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Padding(
      padding: margin == null ? const EdgeInsets.all(0) : margin!,
      child: TextButton(
        onPressed: onPressed as void Function()?,
        style: flatButtonStyle,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null
              ? Image.asset(
                  icon!,
                  color: iconColor != null ? iconColor : Colors.transparent,
                  width: iconSize20,
                  height: iconSize20,
                )
              : const SizedBox(),
          SizedBox(width: icon != null ? paddingSize5 : 0),
          Text(buttonText,
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                color: textColor,
                fontSize: fontSize ?? fontSize16,
              )),
        ]),
      ),
    );
  }
}
