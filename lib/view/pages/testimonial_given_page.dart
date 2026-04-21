import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/viewModel/members_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestimonialGivenPage extends StatefulWidget {
  TestimonialGivenPageState createState() => TestimonialGivenPageState();
}

class TestimonialGivenPageState extends State<TestimonialGivenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembersViewmodel>(builder: (membersVM) {
      return Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            "Testimonials Given".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _givenTestimonialListItems(index, membersVM);
            },
            itemCount: 30,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _givenTestimonialListItems(int index, MembersViewmodel membersVM) {
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: ListTile(
        contentPadding: EdgeInsets.all(paddingSize10),
        onTap: () {
          // Get.toNamed(Routes.getTestimonialDetailsPageRoute());
        },
        leading: Image.asset(
          profileImage,
          width: 62.0,
          height: 62.0,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Priya Patel",
              style:
                  fontBold.copyWith(color: midnightBlue, fontSize: fontSize18),
            ),
            Text(
              "Digital Marketing",
              style:
                  fontRegular.copyWith(color: greyText, fontSize: fontSize12),
            ),
            Text(
              "Alphabit Infoway",
              style:
                  fontRegular.copyWith(color: greyText, fontSize: fontSize12),
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
