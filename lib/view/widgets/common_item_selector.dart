import 'package:flutter/cupertino.dart';

class CommonItemSelector extends StatefulWidget {
  final List<String>? labels;
  final Color? itemSelectedColor;
  final Color? itemUnSelectedColor;
  final Function? onPressed;

  CommonItemSelector(
      {Key? key,
      this.labels,
      this.itemSelectedColor,
      this.itemUnSelectedColor,
      this.onPressed})
      : super(key: key);

  CommonItemSelectorState createState() => CommonItemSelectorState();
}

class CommonItemSelectorState extends State<CommonItemSelector> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
