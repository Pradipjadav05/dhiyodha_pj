import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:flutter/material.dart';

class CommonTextLabel extends StatefulWidget {
  final Color? bgColor;
  final String labelText;
  final Color? textColor;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const CommonTextLabel({
    Key? key,
    this.bgColor = lavenderMist,
    this.textColor = bluishPurple,
    this.padding,
    this.textStyle,
    required this.labelText,
  }) : super(key: key);

  @override
  CommonTextLabelState createState() => CommonTextLabelState();
}

class CommonTextLabelState extends State<CommonTextLabel> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius10),
      ),
      color: widget.bgColor ?? null,
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(8.0),
        child: Text(widget.labelText,
            textAlign: TextAlign.center,
            style: widget.textStyle ??
                fontMedium.copyWith(
                  color: widget.textColor,
                  fontSize: fontSize16,
                )),
      ),
    );
  }
}
