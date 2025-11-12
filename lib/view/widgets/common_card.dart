import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:flutter/material.dart';

class CommonCard extends StatefulWidget {
  final Widget cardChild;
  final Color? bgColor;
  final double? elevation;
  final Function? onTap;
  final double? radius;

  const CommonCard({
    Key? key,
    this.bgColor,
    this.elevation = 4.0,
    this.onTap,
    this.radius = radius10,
    required this.cardChild,
  }) : super(key: key);

  @override
  CommonCardState createState() => CommonCardState();
}

class CommonCardState extends State<CommonCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.elevation,
      semanticContainer: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius ?? radius10),
      ),
      color: widget.bgColor ?? null,
      child: InkWell(
          onTap: widget.onTap as void Function()?, child: widget.cardChild),
    );
  }
}
