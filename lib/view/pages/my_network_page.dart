import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/viewModel/my_network_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyNetworkPage extends StatefulWidget {
  MyNetworkPageState createState() => MyNetworkPageState();
}

class MyNetworkPageState extends State<MyNetworkPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyNetworkViewModel>(builder: (myNetworkVM) {
      return Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            "Network",
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          menuWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              customBorder: new CircleBorder(),
              onTap: () {
                Get.toNamed(Routes.getWebViewPageRoute(queryWebUrl));
              },
              child: Image.asset(
                query,
                width: 24.0,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: paddingSize10, horizontal: paddingSize15),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: paddingSize15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CommonCard(
                            elevation: 2.0,
                            bgColor: myNetworkVM.connectionsTab.value
                                ? bluishPurple
                                : lavenderMist,
                            onTap: () async {
                              myNetworkVM.testimonialTab.value = false;
                              myNetworkVM.connectionsTab.value = true;
                            },
                            cardChild: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize15,
                                  vertical: paddingSize10),
                              child: Center(
                                child: Text(
                                  "Connections".tr,
                                  style: fontMedium.copyWith(
                                      color: myNetworkVM.connectionsTab.value
                                          ? white
                                          : black,
                                      fontSize: fontSize14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: paddingSize15),
                        Expanded(
                          child: CommonCard(
                            elevation: 2.0,
                            bgColor: myNetworkVM.testimonialTab.value
                                ? bluishPurple
                                : lavenderMist,
                            onTap: () {
                              myNetworkVM.testimonialTab.value = true;
                              myNetworkVM.connectionsTab.value = false;
                            },
                            cardChild: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize15,
                                  vertical: paddingSize10),
                              child: Center(
                                child: Text(
                                  "Testimonials".tr,
                                  style: fontMedium.copyWith(
                                      color: myNetworkVM.testimonialTab.value
                                          ? white
                                          : black,
                                      fontSize: fontSize14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: paddingSize15),
                    CommonCard(
                      onTap: () {
                        myNetworkVM.testimonialTab.value
                            ? "Testimonials Received (07)"
                            : "My Connections (08)";
                        myNetworkVM.testimonialTab.value
                            ? Get.toNamed(
                                Routes.getTestimonialReceivedPageRoute())
                            : Get.toNamed(Routes.getMyConnectionsPageRoute());
                      },
                      elevation: 0.0,
                      bgColor: lavenderMist,
                      cardChild: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: paddingSize15, horizontal: paddingSize15),
                        child: Row(
                          children: [
                            Image.asset(
                              myNetworkVM.testimonialTab.value
                                  ? testimonialReceived
                                  : connections,
                              height: iconSize20,
                              width: iconSize20,
                            ),
                            SizedBox(width: paddingSize10),
                            Text(
                              myNetworkVM.testimonialTab.value
                                  ? "Testimonials Received (07)"
                                  : "My Connections (08)",
                              style: fontMedium.copyWith(
                                  color: midnightBlue, fontSize: fontSize14),
                            ),
                            Spacer(),
                            Image.asset(
                              nextArrow,
                              color: midnightBlue,
                              height: iconSize18,
                              width: iconSize18,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: paddingSize10),
                    CommonCard(
                      onTap: () {
                        myNetworkVM.testimonialTab.value
                            ? "Testimonials Given (05)"
                            : "Sent Requests (04)";
                        myNetworkVM.testimonialTab.value
                            ? Get.toNamed(Routes.getTestimonialGivenPageRoute())
                            : Get.toNamed(Routes.getSentRequestPageRoute());
                      },
                      elevation: 0.0,
                      bgColor: lavenderMist,
                      cardChild: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: paddingSize15, horizontal: paddingSize15),
                        child: Row(
                          children: [
                            Image.asset(
                              myNetworkVM.testimonialTab.value
                                  ? testimonialGiven
                                  : connectionSend,
                              height: iconSize20,
                              width: iconSize20,
                            ),
                            SizedBox(width: paddingSize10),
                            Text(
                              myNetworkVM.testimonialTab.value
                                  ? "Testimonials Given (05)"
                                  : "Sent Requests (04)",
                              style: fontMedium.copyWith(
                                  color: midnightBlue, fontSize: fontSize14),
                            ),
                            Spacer(),
                            Image.asset(
                              nextArrow,
                              color: midnightBlue,
                              height: iconSize20,
                              width: iconSize20,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: paddingSize10),
                    CommonCard(
                      onTap: () {
                        myNetworkVM.testimonialTab.value
                            ? "Testimonials Requests (01)"
                            : "Received Requests (06)";
                        myNetworkVM.testimonialTab.value
                            ? Get.toNamed(
                                Routes.getTestimonialRequestPageRoute())
                            : Get.toNamed(Routes.getReceiveRequestPageRoute());
                      },
                      elevation: 0.0,
                      bgColor: lavenderMist,
                      cardChild: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: paddingSize15, horizontal: paddingSize15),
                        child: Row(
                          children: [
                            Image.asset(
                              myNetworkVM.testimonialTab.value
                                  ? testimonialReceived
                                  : connectionReceived,
                              height: iconSize18,
                              width: iconSize18,
                            ),
                            SizedBox(width: paddingSize10),
                            Text(
                              myNetworkVM.testimonialTab.value
                                  ? "Testimonials Requests (01)"
                                  : "Received Requests (06)",
                              style: fontMedium.copyWith(
                                  color: midnightBlue, fontSize: fontSize14),
                            ),
                            Spacer(),
                            Image.asset(
                              nextArrow,
                              color: midnightBlue,
                              height: iconSize18,
                              width: iconSize18,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
}
