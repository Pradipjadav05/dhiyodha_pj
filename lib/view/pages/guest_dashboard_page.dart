import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/pages/authentication_page.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/viewModel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestDashboardPage extends StatefulWidget {
  GuestDashboardPageState createState() => GuestDashboardPageState();
}

class GuestDashboardPageState extends State<GuestDashboardPage> {
  // late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    initAPIS();
  }

  Future<void> initAPIS() async {
    await Get.find<HomeViewModel>().guestDashboardData();
    // _controller = YoutubePlayerController(
    //   initialVideoId: 'WcMc8FKdtwQ',
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeViewModel>(builder: (homeVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Image.asset(
              appLogoLong,
              width: 120.0,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(paddingSize15),
                child: InkWell(
                  onTap: () async {
                    await homeVM.clearSharedPreferenceAndLogout();
                    Get.offAll(new AuthenticationPage());
                  },
                  child: Image.asset(
                    logout,
                    height: 24.0,
                    width: 24.0,
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize10, vertical: paddingSize15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _bannerSlider(homeVM),
                      SizedBox(height: paddingSize30),
                      _testimonialSlider(homeVM),
                      SizedBox(height: paddingSize15),
                    ],
                  ),
                ),
                _achievements(),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _bannerSlider(HomeViewModel homeVM) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 350.0,
        viewportFraction: 1.0,
      ),
      items: homeVM.guestBannerList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: i.url!,
              ),
            );
          },
        );
      }).toList(),
    );
    // return InkWell(
    //   onTap: () {
    //     Get.toNamed(Routes.getProfileRoute());
    //   },
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(radius10),
    //       image: DecorationImage(
    //         image: AssetImage(profileBg),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(vertical: paddingSize30),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Image.asset(
    //             profileImage,
    //             height: 68.0,
    //             width: 68.0,
    //           ),
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Poonam Tala",
    //                     style: fontBold.copyWith(
    //                         fontSize: fontSize22, color: ghostWhite),
    //                   ),
    //                   SizedBox(width: 4.0),
    //                   Image.asset(live),
    //                 ],
    //               ),
    //               Text(
    //                 "BNI Utsav",
    //                 style: fontRegular.copyWith(
    //                     fontSize: fontSize14, color: periwinkle),
    //               ),
    //               Text(
    //                 "Due date : 30/01/2024",
    //                 style: fontRegular.copyWith(
    //                     fontSize: fontSize14, color: periwinkle),
    //               )
    //             ],
    //           ),
    //           Image.asset(
    //             arrowWhite,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  _testimonialSlider(HomeViewModel homeVM) {
    return Padding(
      padding: const EdgeInsets.only(
          right: paddingSize15, left: paddingSize15, bottom: paddingSize15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "guest_testimonial".tr,
                  style: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                ),
              ),
              Expanded(
                child: Divider(
                  color: midnightBlue,
                ),
              )
            ],
          ),
          SizedBox(height: paddingSize20),
          SizedBox(
            height: 160.0,
            width: Get.width,
            child: ListView.builder(
                itemCount: homeVM.reelList.length,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 160.0,
                              width: 100.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                // homeVM.reelList[index]
                                //     .toString()
                                //     .contains("youtu.be")
                                //     ? YoutubePlayer(controller: _controller)
                                //     :
                                child: Opacity(
                                  opacity: 0.7,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: homeVM.reelList[index].toString(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 160.0,
                              width: 100.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    color: midnightBlue,
                                    playBtn,
                                    height: 24.0,
                                    width: 24.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  _achievements() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: lavenderMist,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0),
              topRight: Radius.circular(60.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: paddingSize20,
                top: paddingSize55,
                right: paddingSize30,
                left: paddingSize30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          achievementBg,
                          height: 100.0,
                          width: 72.0,
                        ),
                        Positioned(
                          top: 38.0,
                          left: 10.0,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "100+",
                                  style: fontBold.copyWith(
                                      color: white, fontSize: fontSize16),
                                ),
                                Text(
                                  "project_seller".tr,
                                  style: fontRegular.copyWith(
                                      color: spunPearl, fontSize: fontSize10),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Stack(
                        children: [
                          Image.asset(
                            achievementBg,
                            height: 100.0,
                            width: 72.0,
                          ),
                          Positioned(
                            top: 38.0,
                            left: 10.0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "100+",
                                    style: fontBold.copyWith(
                                        color: white, fontSize: fontSize16),
                                  ),
                                  Text(
                                    "service_seller".tr,
                                    style: fontRegular.copyWith(
                                        color: spunPearl, fontSize: fontSize10),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          achievementBg,
                          height: 100.0,
                          width: 72.0,
                        ),
                        Positioned(
                          top: 38.0,
                          left: 10.0,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "100+",
                                  style: fontBold.copyWith(
                                      color: white, fontSize: fontSize16),
                                ),
                                Text(
                                  "skill_seller".tr,
                                  style: fontRegular.copyWith(
                                      color: spunPearl, fontSize: fontSize10),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Stack(
                        children: [
                          Image.asset(
                            achievementBg,
                            height: 100.0,
                            width: 72.0,
                          ),
                          Positioned(
                            top: 38.0,
                            left: 10.0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "100+",
                                    style: fontBold.copyWith(
                                        color: white, fontSize: fontSize16),
                                  ),
                                  Text(
                                    "mentors_seller".tr,
                                    style: fontRegular.copyWith(
                                        color: spunPearl, fontSize: fontSize10),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: paddingSize55),
                _partners(),
                SizedBox(height: paddingSize40),
                CommonButton(
                  fontSize: fontSize16,
                  bgColor: midnightBlue,
                  buttonText: "become_member".tr,
                  onPressed: () async {
                    Get.toNamed(Routes.getWebViewPageRoute(queryWebUrl));
                  },
                  textColor: periwinkle,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -15,
          left: MediaQuery.of(context).size.width * 0.2,
          child: CommonCard(
            elevation: 0.0,
            bgColor: bluishPurple,
            cardChild: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize15, vertical: paddingSize5),
              child: Text(
                "achievements".tr,
                style: fontRegular.copyWith(
                    color: ghostWhite, fontSize: fontSize14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _partners() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "partners".tr,
                style: fontRegular.copyWith(
                    color: midnightBlue, fontSize: fontSize14),
              ),
            ),
            Expanded(
              child: Divider(
                color: midnightBlue,
              ),
            )
          ],
        ),
        SizedBox(height: paddingSize20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: ghostWhite,
                  borderRadius: BorderRadius.circular(radius10)),
              child: Center(
                child: Image.asset(partners),
              ),
            ),
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: ghostWhite,
                  borderRadius: BorderRadius.circular(radius10)),
              child: Center(
                child: Image.asset(partners),
              ),
            ),
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: ghostWhite,
                  borderRadius: BorderRadius.circular(radius10)),
              child: Center(
                child: Image.asset(partners),
              ),
            ),
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: ghostWhite,
                  borderRadius: BorderRadius.circular(radius10)),
              child: Center(
                child: Image.asset(partners),
              ),
            ),
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: ghostWhite,
                  borderRadius: BorderRadius.circular(radius10)),
              child: Center(
                child: Image.asset(partners),
              ),
            ),
          ],
        ),
        SizedBox(height: paddingSize10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: ghostWhite,
                  borderRadius: BorderRadius.circular(radius10)),
              child: Center(
                child: Image.asset(partners),
              ),
            ),
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: ghostWhite,
                  borderRadius: BorderRadius.circular(radius10)),
              child: Center(
                child: Image.asset(partners),
              ),
            ),
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: ghostWhite,
                  borderRadius: BorderRadius.circular(radius10)),
              child: Center(
                child: Image.asset(partners),
              ),
            ),
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: ghostWhite,
                  borderRadius: BorderRadius.circular(radius10)),
              child: Center(
                child: Image.asset(partners),
              ),
            ),
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                  color: ghostWhite,
                  borderRadius: BorderRadius.circular(radius10)),
              child: Center(
                child: Image.asset(partners),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
