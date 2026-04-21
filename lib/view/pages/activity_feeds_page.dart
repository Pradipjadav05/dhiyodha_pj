import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/viewModel/activity_feeds_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityFeedsPage extends StatefulWidget {
  ActivityFeedsPageState createState() => ActivityFeedsPageState();
}

class ActivityFeedsPageState extends State<ActivityFeedsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityFeedsViewmodel>(builder: (afvm) {
      return Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            "Activity Feed".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(paddingSize15),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CommonCard(
                            elevation: 2.0,
                            bgColor: afvm.isGivenFeed.value
                                ? midnightBlue
                                : lavenderMist,
                            onTap: () {
                              afvm.isGivenFeed.value = true;
                              afvm.isReceivedFeed.value = false;
                            },
                            cardChild: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize15,
                                  vertical: paddingSize10),
                              child: Center(
                                child: Text(
                                  "Given".tr,
                                  style: fontRegular.copyWith(
                                      color: afvm.isGivenFeed.value
                                          ? white
                                          : black,
                                      fontSize: fontSize14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CommonCard(
                            elevation: 2.0,
                            bgColor: afvm.isReceivedFeed.value
                                ? midnightBlue
                                : lavenderMist,
                            onTap: () {
                              afvm.isGivenFeed.value = false;
                              afvm.isReceivedFeed.value = true;
                            },
                            cardChild: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize15,
                                  vertical: paddingSize10),
                              child: Center(
                                child: Text(
                                  "Received".tr,
                                  style: fontRegular.copyWith(
                                      color: afvm.isReceivedFeed.value
                                          ? white
                                          : black,
                                      fontSize: fontSize14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: paddingSize10),
                        InkWell(
                            onTap: () async {
                              await _showFilterPopup();
                            },
                            child: Image.asset(
                              filter,
                              width: iconSize24,
                              height: iconSize24,
                            ))
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _activityFeedsListItems(index, afvm);
                  },
                  itemCount: 30,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _showFilterPopup() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: paddingSize25),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: paddingSize10, horizontal: paddingSize20),
                  child: InkWell(
                    child: Row(
                      children: [
                        Image.asset(tyfcbs,
                            color: bluishPurple,
                            height: iconSize24,
                            width: iconSize24),
                        SizedBox(width: paddingSize10),
                        Text(
                          "TYFCBs",
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: paddingSize10, horizontal: paddingSize20),
                  child: InkWell(
                    child: Row(
                      children: [
                        Image.asset(referrals,
                            color: bluishPurple,
                            height: iconSize24,
                            width: iconSize24),
                        SizedBox(width: paddingSize10),
                        Text(
                          "Referrals",
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: paddingSize10, horizontal: paddingSize20),
                  child: InkWell(
                    child: Row(
                      children: [
                        Image.asset(oneToOne,
                            color: bluishPurple,
                            height: iconSize24,
                            width: iconSize24),
                        SizedBox(width: paddingSize10),
                        Text(
                          "One-to-Ones",
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: paddingSize10, horizontal: paddingSize20),
                  child: InkWell(
                    child: Row(
                      children: [
                        Image.asset(training,
                            color: bluishPurple,
                            height: iconSize24,
                            width: iconSize24),
                        SizedBox(width: paddingSize10),
                        Text(
                          "Training",
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: paddingSize25),
              ],
            ),
          ),
        );
      },
    );
  }

  _activityFeedsListItems(int index, ActivityFeedsViewmodel membersVM) {
    return Padding(
      padding: const EdgeInsets.all(paddingSize10),
      child: ListTile(
        contentPadding: EdgeInsets.all(paddingSize10),
        onTap: () {
          switch (index) {
            case 0:
              Get.toNamed(Routes.getTyfcbDetailsPage());
              break;
            case 1:
              Get.toNamed(Routes.getOneToOneDetailsPage());
              break;
            case 2:
              Get.toNamed(Routes.getReferralDetailsPage());
              break;
            default:
              Get.toNamed(Routes.getTyfcbDetailsPage());
              break;
          }
        },
        leading: Image.asset(
          connections,
          width: iconSize24,
          height: iconSize24,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "October 29, 2024",
              style: fontMedium.copyWith(color: greyText, fontSize: fontSize14),
            ),
            Text(
              "Kevin Patel - October 28,2024",
              style: fontMedium.copyWith(
                  color: midnightBlue, fontSize: fontSize14),
            ),
          ],
        ),
        trailing: Image.asset(
          nextArrow,
          width: iconSize18,
          height: iconSize18,
        ),
      ),
    );
  }
}
