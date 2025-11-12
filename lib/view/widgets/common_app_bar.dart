import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool isBackButtonExist;
  final Widget? menuWidget;
  final Widget? leadingIcon;
  final Function? onTap;

  const CommonAppBar(
      {Key? key,
      required this.title,
      this.isBackButtonExist = true,
      this.menuWidget,
      this.leadingIcon,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: true,
      leading: isBackButtonExist
          ? IconButton(
              icon: const Icon(
                color: midnightBlue,
                Icons.arrow_back_ios,
                size: 20.0,
              ),
              color: Theme.of(context).textTheme.bodyLarge!.color,
              onPressed: onTap as void Function()? ??
                  () => Get.back(closeOverlays: true),
            )
          : leadingIcon != null
              ? leadingIcon
              : const SizedBox(),
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
      bottom: PreferredSize(
          child: Container(
            color: divider,
            height: 0.4,
          ),
          preferredSize: Size.fromHeight(4.0)),
      actions: menuWidget != null ? [menuWidget!] : null,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
