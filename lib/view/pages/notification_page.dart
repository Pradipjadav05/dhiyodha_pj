import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/viewModel/asks_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<AsksViewModel>(builder: (askVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "notification".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _notificationListItems(index);
            },
            itemCount: 8,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _notificationListItems(int index) {
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: CommonCard(
        bgColor: white,
        elevation: 0.0,
        cardChild: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    blueRound,
                    width: 14.0,
                    height: 14.0,
                  ),
                  SizedBox(width: paddingSize15),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kevin Patel",
                        style: fontBold.copyWith(
                            fontSize: fontSize16, color: midnightBlue),
                      ),
                      Text(
                        "Recently join your chapter",
                        style: fontMedium.copyWith(
                            fontSize: fontSize12, color: bluishPurple),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    "15min ago",
                    style: fontRegular.copyWith(
                        color: greyText, fontSize: fontSize12),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 0.4,
            )
          ],
        ),
      ),
    );
  }
}
