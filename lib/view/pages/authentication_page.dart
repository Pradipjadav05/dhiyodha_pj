import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPageState createState() => AuthenticationPageState();
}

class AuthenticationPageState extends State<AuthenticationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: midnightBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: paddingSize55),
                Image.asset(
                  appLogo,
                  height: 80.0,
                  width: 80.0,
                ),
                SizedBox(height: paddingSize55),
                Text(
                  "wlcm_to_dhiyodha".tr,
                  style: fontRegular.copyWith(
                      color: lavenderMist, fontSize: fontSize14),
                ),
                SizedBox(height: paddingSize10),
                Text(
                  "strength_nation".tr,
                  style: fontBold.copyWith(
                      color: lavenderMist, fontSize: fontSize24),
                ),
                SizedBox(height: paddingSize100),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: paddingSize15),
                  child: CommonButton(
                    bgColor: ghostWhite,
                    buttonText: "login".tr,
                    textColor: midnightBlue,
                    onPressed: () {
                      Get.toNamed(Routes.getLoginPageRoute());
                    },
                  ),
                ),
                SizedBox(height: paddingSize20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: paddingSize15),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(radius10)),
                        gradient:
                            LinearGradient(colors: [gradientOne, gradientTwo])),
                    child: CommonButton(
                      isGradient: true,
                      textColor: ghostWhite,
                      buttonText: "continue_with_mobile".tr,
                      onPressed: () {
                        Get.toNamed(
                          Routes.getGuestLoginPageRoute(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Image.asset(
        womenBg,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
