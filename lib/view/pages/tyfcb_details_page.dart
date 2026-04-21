import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TyfcbDetailsPage extends StatefulWidget {
  TyfcbDetailsPageState createState() => TyfcbDetailsPageState();
}

class TyfcbDetailsPageState extends State<TyfcbDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text("TYFBC Slip",
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
      body: SafeArea(
        child: SingleChildScrollView(
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
                          tyfcbs,
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
                    Image.asset(profileImage, width: 62.0, height: 62.0),
                    SizedBox(width: paddingSize20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thank You to:",
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
                        "For a referral in the amount of:",
                        style: fontMedium.copyWith(
                            color: greyText, fontSize: fontSize14),
                      ),
                      Text(
                        "₹ 1234 ",
                        style: fontBold.copyWith(
                            color: bluishPurple, fontSize: fontSize18),
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
                        "Business Type:",
                        style: fontMedium.copyWith(
                            color: greyText, fontSize: fontSize14),
                      ),
                      Text(
                        "New",
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
                        "Comments:",
                        style: fontMedium.copyWith(
                            color: greyText, fontSize: fontSize14),
                      ),
                      Text(
                        "Thank you",
                        style: fontBold.copyWith(
                            color: midnightBlue, fontSize: fontSize18),
                      )
                    ],
                  ),
                ),
                SizedBox(height: paddingSize20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
