import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/members_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MemberProfilePage extends StatefulWidget {
  MembersChildData membersChildData;

  MemberProfilePageState createState() => MemberProfilePageState();

  MemberProfilePage({required this.membersChildData});
}

class MemberProfilePageState extends State<MemberProfilePage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    Get.find<MembersViewmodel>().testimonialDataList = [];
    await Get.find<MembersViewmodel>()
        .getUserWiseTestimonial(widget.membersChildData.uuid!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<MembersViewmodel>(
      builder: (memberVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "member_profile".tr,
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: paddingSize20),
                  _personProfileCard(),
                  SizedBox(height: paddingSize20),
                  _contactWays(),
                  SizedBox(height: paddingSize20),
                  _businessProfileCard(),
                  SizedBox(height: paddingSize25),
                  _testimonialActionButtons(),
                  SizedBox(height: paddingSize40),
                  _businessCardDetails(),
                  SizedBox(height: paddingSize40),
                  _testimonialCardDetails(memberVM)
                ],
              ),
            ),
          ),
        );
      },
    ));
  }

  _contactWays() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingSize25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CommonCard(
            radius: radius5,
            cardChild: Padding(
              padding: const EdgeInsets.all(paddingSize15),
              child: Image.asset(
                call,
                width: iconSize22,
                height: iconSize22,
              ),
            ),
            bgColor: lavenderMist,
            onTap: () async {
              launchUrlString(
                  "tel://${widget.membersChildData.organization?.companyContact}");
            },
          ),
          CommonCard(
            radius: radius5,
            cardChild: Padding(
              padding: const EdgeInsets.all(paddingSize15),
              child: Image.asset(
                mail,
                width: iconSize22,
                height: iconSize22,
              ),
            ),
            bgColor: lavenderMist,
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: '${widget.membersChildData.organization?.companyEmail}',
                query: 'Connect with Dhiyodha',
              );
              launchUrl(emailLaunchUri);
            },
          ),
          CommonCard(
            radius: radius5,
            cardChild: Padding(
              padding: const EdgeInsets.all(paddingSize15),
              child: Image.asset(
                share,
                width: iconSize22,
                height: iconSize22,
              ),
            ),
            bgColor: lavenderMist,
            onTap: () async {
              String data =
                  'Profile Information \n${widget.membersChildData?.firstName} ${widget.membersChildData?.lastName} \n${widget.membersChildData?.mobileNo} '
                  '\n${widget.membersChildData?.organization?.companyName} \n${widget.membersChildData?.organization?.businessCategory} \n\n Download App Now - $playStoreUrl';
              await Share.share(data);
            },
          ),
          // CommonCard(
          //   radius: radius5,
          //   cardChild: Padding(
          //     padding: const EdgeInsets.all(paddingSize15),
          //     child: Image.asset(
          //       more,
          //       width: iconSize20,
          //       height: iconSize20,
          //     ),
          //   ),
          //   bgColor: lavenderMist,
          //   onTap: () {},
          // )
        ],
      ),
    );
  }

  _personProfileCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius10),
        image: DecorationImage(
          image: AssetImage(profileBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: paddingSize20, horizontal: paddingSize20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   profileImage,
            //   height: 68.0,
            //   width: 68.0,
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:
              widget.membersChildData.profileUrl !=
                  null &&
                  widget.membersChildData.profileUrl!.isNotEmpty
                  ? CachedNetworkImage(
                height: 68.0,
                width: 68.0,
                imageUrl: widget.membersChildData.profileUrl!,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                const Center(
                  child:
                  CircularProgressIndicator(
                      strokeWidth: 2),
                ),
                errorWidget:
                    (context, url, error) =>
                    Image.asset(
                      profileImage,
                      height: 68.0,
                      width: 68.0,
                      fit: BoxFit.fill,
                    ),
              )
                  : Image.asset(
                profileImage,
                height: 68.0,
                width: 68.0,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: paddingSize15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.membersChildData.firstName} ${widget.membersChildData.lastName}',
                  style: fontBold.copyWith(
                      fontSize: fontSize22, color: ghostWhite),
                ),
                Text(
                  '${widget.membersChildData.organization?.businessCategory}',
                  style: fontRegular.copyWith(
                      fontSize: fontSize14, color: periwinkle),
                ),
                Text(
                  '${widget.membersChildData.organization?.companyName}',
                  style: fontRegular.copyWith(
                      fontSize: fontSize14, color: lavenderMist),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _businessProfileCard() {
    return CommonCard(
      radius: radius15,
      elevation: 0.0,
      bgColor: lavenderMist,
      cardChild: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: paddingSize20, horizontal: paddingSize25),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize20, vertical: paddingSize15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: bluishPurple,
                          border: Border.all(
                              color: const Color(0xFFE3E8F4), width: 1.5),
                        ),
                        child: Center(
                          child: Text(
                            (widget.membersChildData.organization?.companyName ?? 'A')
                                .substring(0, 1)
                                .toUpperCase(),
                            style: fontBold.copyWith(
                                fontSize: fontSize18, color: white),
                          ),
                        ),
                      ),
                      SizedBox(width: paddingSize15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.membersChildData.organization?.companyName}',
                              style: fontBold.copyWith(
                                  fontSize: fontSize14, color: midnightBlue),
                            ),
                            Text(
                              '${widget.membersChildData.organization?.businessCategory}',
                              style: fontRegular.copyWith(
                                  fontSize: fontSize10, color: midnightBlue),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize10, vertical: paddingSize10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(call, height: iconSize18, width: iconSize18),
                  SizedBox(width: paddingSize5),
                  Text(
                    '${widget.membersChildData.organization?.companyContact}',
                    style: fontRegular.copyWith(
                        fontSize: fontSize12, color: midnightBlue),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize10, vertical: paddingSize10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(mail, height: iconSize18, width: iconSize18),
                      SizedBox(width: paddingSize5),
                      Text(
                        '${widget.membersChildData.organization?.companyEmail}',
                        style: fontRegular.copyWith(
                            fontSize: fontSize12, color: midnightBlue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize10, vertical: paddingSize10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(location,
                          height: iconSize18, width: iconSize18),
                      SizedBox(width: paddingSize5),
                      Text(
                        '${widget.membersChildData.address?.city}',
                        style: fontRegular.copyWith(
                            fontSize: fontSize12, color: midnightBlue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _testimonialActionButtons() {
    return Row(
      children: [
        Expanded(
          child: CommonButton(
            fontSize: fontSize12,
            buttonText: "give_testimonial".tr,
            bgColor: midnightBlue,
            textColor: periwinkle,
            onPressed: () async {
              bool isResult = await Get.toNamed(
                  Routes.getAddTestimonialPageRoute(widget.membersChildData));
              if (isResult ?? false) {
                await Get.find<MembersViewmodel>()
                    .getUserWiseTestimonial(widget.membersChildData.uuid!);
              }
            },
          ),
        ),
        // SizedBox(width: paddingSize15),
        // Expanded(
        //   child: CommonButton(
        //     fontSize: fontSize12,
        //     buttonText: "Ask for Testimonial".tr,
        //     bgColor: lavenderMist,
        //     textColor: bluishPurple,
        //     onPressed: () {
        //       Get.toNamed(Routes.getRequestTestimonialPageRoute());
        //     },
        //   ),
        // )
      ],
    );
  }

  _businessCardDetails() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CommonCard(
          onTap: () {},
          elevation: 0.0,
          bgColor: lavenderMist,
          cardChild: Padding(
            padding: const EdgeInsets.only(
                bottom: paddingSize20,
                top: paddingSize30,
                right: paddingSize30,
                left: paddingSize30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextFormField(
                  isEnabled: false,
                  maxLines: 6,
                  hintText:
                      '${widget.membersChildData.organization?.businessCategory}',
                  textStyle: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -15,
          left: 20,
          child: CommonCard(
            elevation: 0.0,
            bgColor: bluishPurple,
            cardChild: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize15, vertical: paddingSize5),
              child: Text(
                "my_business".tr,
                style: fontRegular.copyWith(
                    color: ghostWhite, fontSize: fontSize14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _testimonialCardDetails(MembersViewmodel memberVM) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250,
            viewportFraction: 1.0,
          ),
          items: memberVM.testimonialDataList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return CommonCard(
                  onTap: () {},
                  elevation: 0.0,
                  bgColor: lavenderMist,
                  cardChild: Padding(
                    padding: const EdgeInsets.only(
                        bottom: paddingSize20,
                        top: paddingSize30,
                        right: paddingSize30,
                        left: paddingSize30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (i.reviewerPofileUrl != null &&
                                i.reviewerPofileUrl!.isNotEmpty)
                              CachedNetworkImage(
                                imageUrl: i.reviewerPofileUrl!,
                                width: 42.0,
                                height: 42.0,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  profileImage,
                                  width: 42.0,
                                  height: 42.0,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              Image.asset(
                                profileImage,
                                width: 42.0,
                                height: 42.0,
                                fit: BoxFit.cover,
                              ),
                            SizedBox(width: paddingSize15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${i.reviewerFirstName} ${i.reviewerLastName}',
                                  style: fontBold.copyWith(
                                      fontSize: fontSize12,
                                      color: midnightBlue),
                                ),
                                Text(
                                  '${i.reviewer?.organization?.businessCategory}',
                                  style: fontRegular.copyWith(
                                      fontSize: fontSize10,
                                      color: midnightBlue),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: paddingSize10),
                        CommonTextFormField(
                          isEnabled: false,
                          maxLines: 6,
                          hintText: "${i.review}",
                          textStyle: fontRegular.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          top: -15,
          left: 20,
          child: CommonCard(
            elevation: 0.0,
            bgColor: bluishPurple,
            cardChild: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize15, vertical: paddingSize5),
              child: Text(
                memberVM.testimonialDataList.isNotEmpty
                    ? "testimonials".tr
                    : "no_test_found".tr,
                style: fontRegular.copyWith(
                    color: ghostWhite, fontSize: fontSize14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
