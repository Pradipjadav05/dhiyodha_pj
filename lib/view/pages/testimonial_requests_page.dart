import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/viewModel/members_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestimonialRequestsPage extends StatefulWidget {
  TestimonialRequestsPageState createState() => TestimonialRequestsPageState();
}

class TestimonialRequestsPageState extends State<TestimonialRequestsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MembersViewmodel>(builder: (membersVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "Testimonials Request".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _requestListItems(index, membersVM);
            },
            itemCount: 30,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _requestListItems(int index, MembersViewmodel membersVM) {
    return Padding(
        padding: const EdgeInsets.all(paddingSize25),
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.getTestimonialRequestActionPageRoute());
          },
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    profileImage,
                    width: 62.0,
                    height: 62.0,
                  ),
                  SizedBox(width: paddingSize15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Priya Patel",
                        style: fontBold.copyWith(
                            color: midnightBlue, fontSize: fontSize18),
                      ),
                      Text(
                        "Digital Marketing",
                        style: fontRegular.copyWith(
                            color: greyText, fontSize: fontSize12),
                      ),
                      Text(
                        "Alphabit Infoway",
                        style: fontRegular.copyWith(
                            color: greyText, fontSize: fontSize12),
                      ),
                    ],
                  ),
                  Spacer(),
                  Image.asset(
                    nextArrow,
                    width: iconSize18,
                    height: iconSize18,
                  ),
                ],
              ),
              SizedBox(height: paddingSize25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CommonButton(
                      fontSize: fontSize12,
                      buttonText: "Give".tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: paddingSize15),
                  Expanded(
                    child: CommonButton(
                      fontSize: fontSize12,
                      buttonText: "Ignore".tr,
                      bgColor: lavenderMist,
                      textColor: bluishPurple,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: paddingSize15),
                  Expanded(
                    child: CommonButton(
                      fontSize: fontSize12,
                      buttonText: "Reject".tr,
                      bgColor: lavenderMist,
                      textColor: requiredField,
                      onPressed: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
