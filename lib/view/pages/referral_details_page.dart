import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_text_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';

class ReferralDetailsPage extends StatefulWidget {
  ReferralDetailsPageState createState() => ReferralDetailsPageState();
}

class ReferralDetailsPageState extends State<ReferralDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text("Referral Slip",
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color)),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius10),
                  image: DecorationImage(
                    image: AssetImage(profileBg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: paddingSize15, horizontal: paddingSize30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        referrals,
                        height: iconSize26,
                        width: iconSize26,
                        color: ghostWhite,
                      ),
                      SizedBox(width: paddingSize20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "From : Priya Patel",
                            style: fontBold.copyWith(
                                fontSize: fontSize14, color: ghostWhite),
                          ),
                          Text(
                            "date: 29 October 2024",
                            style: fontBold.copyWith(
                                fontSize: fontSize14, color: lavenderMist),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: paddingSize10),
              Divider(),
              SizedBox(height: paddingSize20),
              Row(
                children: [
                  Container(
                    height: 24.0,
                    width: 24.0,
                    decoration: BoxDecoration(
                      color: bluishPurple,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(paddingSize10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "30 October 2024",
                          style: fontMedium.copyWith(
                              color: greyText, fontSize: fontSize14),
                        ),
                        Text(
                          "Got The Business",
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize18),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: paddingSize20),
              Row(
                children: [
                  Image.asset(profileImage, width: 62.0, height: 62.0),
                  SizedBox(width: paddingSize20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "To:",
                        style: fontMedium.copyWith(
                            color: greyText, fontSize: fontSize14),
                      ),
                      Text(
                        "Nice Umang ",
                        style: fontBold.copyWith(
                            color: midnightBlue, fontSize: fontSize18),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: paddingSize20),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(paddingSize10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Referral Type:",
                      style: fontMedium.copyWith(
                          color: greyText, fontSize: fontSize14),
                    ),
                    Text(
                      "Inside",
                      style: fontBold.copyWith(
                          color: midnightBlue, fontSize: fontSize18),
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(paddingSize10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Referral Status:",
                      style: fontMedium.copyWith(
                          color: greyText, fontSize: fontSize14),
                    ),
                    Text(
                      "Told Them You Would Call",
                      style: fontBold.copyWith(
                          color: midnightBlue, fontSize: fontSize18),
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(paddingSize10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Details:",
                      style: fontMedium.copyWith(
                          color: greyText, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize10, horizontal: paddingSize5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: lavenderMist,
                          borderRadius: BorderRadius.circular(radius10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nice Umang",
                              style: fontBold.copyWith(
                                  color: midnightBlue, fontSize: fontSize16),
                            ),
                            SizedBox(height: paddingSize10),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(call,
                                    height: iconSize18, width: iconSize18),
                                SizedBox(width: paddingSize5),
                                Text(
                                  "+91 98989 51211",
                                  style: fontMedium.copyWith(
                                      fontSize: fontSize12,
                                      color: midnightBlue),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: paddingSize10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize10, horizontal: paddingSize5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: lavenderMist,
                          borderRadius: BorderRadius.circular(radius10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(mail,
                                height: iconSize18, width: iconSize18),
                            SizedBox(width: paddingSize5),
                            Text(
                              "alphabitinfoway@gmail.com",
                              style: fontRegular.copyWith(
                                  fontSize: fontSize12, color: midnightBlue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: paddingSize10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize10, horizontal: paddingSize5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: lavenderMist,
                          borderRadius: BorderRadius.circular(radius10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(location,
                                height: iconSize18, width: iconSize18),
                            SizedBox(width: paddingSize5),
                            Text(
                              "1036-RK World Tower, Shital Park,\n150 Ft. Ring Road, Rajkot - 360002",
                              style: fontRegular.copyWith(
                                  fontSize: fontSize12, color: midnightBlue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(paddingSize10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Comments:",
                      style: fontMedium.copyWith(
                          color: greyText, fontSize: fontSize14),
                    ),
                    Text(
                      "For Graphic Design",
                      style: fontBold.copyWith(
                          color: midnightBlue, fontSize: fontSize18),
                    )
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonTextLabel(
                      labelText: "How hot is this referral?",
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize25, vertical: paddingSize8)),
                  Expanded(
                    child: Divider(
                      height: 1.0,
                      color: divider,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GFCheckbox(
                        activeIcon: Icon(
                          Icons.check,
                          color: bluishPurple,
                          size: iconSize20,
                        ),
                        inactiveBgColor: Colors.transparent,
                        inactiveBorderColor: bluishPurple,
                        activeBorderColor: bluishPurple,
                        value: true,
                        activeBgColor: Colors.transparent,
                        size: 24.0,
                        onChanged: (bool? value) {},
                      ),
                      Container(
                        height: 20.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            color: greyText,
                            borderRadius: BorderRadius.circular(4.0)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GFCheckbox(
                        activeIcon: Icon(
                          Icons.check,
                          color: bluishPurple,
                          size: iconSize20,
                        ),
                        inactiveBgColor: Colors.transparent,
                        inactiveBorderColor: bluishPurple,
                        activeBorderColor: bluishPurple,
                        value: true,
                        activeBgColor: Colors.transparent,
                        size: 24.0,
                        onChanged: (bool? value) {},
                      ),
                      Container(
                        height: 20.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                            color: greyText,
                            borderRadius: BorderRadius.circular(4.0)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GFCheckbox(
                        activeIcon: Icon(
                          Icons.check,
                          color: bluishPurple,
                          size: iconSize20,
                        ),
                        inactiveBgColor: Colors.transparent,
                        inactiveBorderColor: bluishPurple,
                        activeBorderColor: bluishPurple,
                        value: true,
                        activeBgColor: Colors.transparent,
                        size: 24.0,
                        onChanged: (bool? value) {},
                      ),
                      Container(
                        height: 20.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                            color: greyText,
                            borderRadius: BorderRadius.circular(4.0)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GFCheckbox(
                        activeIcon: Icon(
                          Icons.check,
                          color: bluishPurple,
                          size: iconSize20,
                        ),
                        inactiveBgColor: Colors.transparent,
                        inactiveBorderColor: bluishPurple,
                        activeBorderColor: bluishPurple,
                        value: true,
                        activeBgColor: Colors.transparent,
                        size: 24.0,
                        onChanged: (bool? value) {},
                      ),
                      Container(
                        height: 20.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                            color: Color(0xFFFF3400),
                            borderRadius: BorderRadius.circular(4.0)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GFCheckbox(
                        activeIcon: Icon(
                          Icons.check,
                          color: bluishPurple,
                          size: iconSize20,
                        ),
                        inactiveBgColor: Colors.transparent,
                        inactiveBorderColor: bluishPurple,
                        activeBorderColor: bluishPurple,
                        value: true,
                        activeBgColor: Colors.transparent,
                        size: 24.0,
                        onChanged: (bool? value) {},
                      ),
                      Container(
                        height: 20.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                            color: greyText,
                            borderRadius: BorderRadius.circular(4.0)),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: paddingSize25),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
