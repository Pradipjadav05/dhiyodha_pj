import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestimonialRequestActionsPage extends StatefulWidget {
  TestimonialRequestActionsPageState createState() =>
      TestimonialRequestActionsPageState();
}

class TestimonialRequestActionsPageState
    extends State<TestimonialRequestActionsPage> {
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
          title: Text(
            "Testimonials Request".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(paddingSize14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      profileImage,
                      width: 62.0,
                      height: 62.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(paddingSize15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Priya Patel",
                            style: fontBold.copyWith(
                                color: midnightBlue, fontSize: fontSize18),
                          ),
                          Text(
                            "29/09/2024",
                            style: fontMedium.copyWith(
                                color: greyText, fontSize: fontSize12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: paddingSize15),
                CommonTextFormField(
                  bgColor: lavenderMist,
                  maxLines: 6,
                  hintText:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla at sapien facilisis, tempus velit sit amet, pellentesque arcu. Proin a felis luctus, convallis tortor vitae, venenatis augue. Nulla facilisi. Sed turpis sem, maximus ut orci ut, auctor aliquam nibh. Nunc pulvinar neque non finibus mollis. Mauris id malesuada velit. Maecenas mollis eget sem sit amet viverra."
                          .tr,
                  textStyle: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize12),
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize40),
                ),
                SizedBox(height: paddingSize55),
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        fontSize: fontSize14,
                        buttonText: "Give".tr,
                        bgColor: midnightBlue,
                        textColor: periwinkle,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: paddingSize15),
                    Expanded(
                      child: CommonButton(
                        fontSize: fontSize14,
                        buttonText: "Ignore".tr,
                        bgColor: lavenderMist,
                        textColor: bluishPurple,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(width: paddingSize15),
                    Expanded(
                      child: CommonButton(
                        fontSize: fontSize14,
                        buttonText: "Reject".tr,
                        bgColor: lavenderMist,
                        textColor: requiredField,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
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
