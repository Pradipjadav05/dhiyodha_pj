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
import 'package:dhiyodha/viewModel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestDashboardPage extends StatefulWidget {
  const GuestDashboardPage({Key? key}) : super(key: key);

  @override
  GuestDashboardPageState createState() => GuestDashboardPageState();
}

class GuestDashboardPageState extends State<GuestDashboardPage> {
  @override
  void initState() {
    super.initState();
    _initAPIs();
  }

  Future<void> _initAPIs() async {
    await Get.find<HomeViewModel>().guestDashboardData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeViewModel>(builder: (homeVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: AppBar(
            backgroundColor: ghostWhite,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Image.asset(appLogoLong, width: 120.0),
            actions: [
              Padding(
                padding: const EdgeInsets.all(paddingSize15),
                child: InkWell(
                  onTap: () async {
                    await homeVM.clearSharedPreferenceAndLogout();
                    Get.offAll(AuthenticationPage());
                  },
                  child: Image.asset(logout, height: 24.0, width: 24.0),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: paddingSize10),

                // ── Banner Carousel ──
                _bannerSlider(homeVM),

                const SizedBox(height: paddingSize20),

                // ── Testimonials ──
                _testimonialSlider(homeVM),

                const SizedBox(height: paddingSize25),

                // ── Achievements + Partners + Button ──
                _achievementsSection(context),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ────────────────────────────────────────────
  // Banner Slider
  // ────────────────────────────────────────────
  Widget _bannerSlider(HomeViewModel homeVM) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220.0,
        viewportFraction: 0.92,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: homeVM.guestBannerList.map((i) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            width: double.infinity,
            imageUrl: i.url!,
            placeholder: (context, url) => Container(color: lavenderMist),
            errorWidget: (context, url, error) =>
                Container(color: lavenderMist),
          ),
        );
      }).toList(),
    );
  }

  // ────────────────────────────────────────────
  // Testimonials
  // ────────────────────────────────────────────
  Widget _testimonialSlider(HomeViewModel homeVM) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingSize15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Text(
                'guest_testimonial'.tr,
                style: fontRegular.copyWith(
                    color: midnightBlue, fontSize: fontSize14),
              ),
              const SizedBox(width: paddingSize10),
              const Expanded(child: Divider(color: midnightBlue)),
            ],
          ),
          const SizedBox(height: paddingSize15),

          // Horizontal reel list
          SizedBox(
            height: 160.0,
            child: ListView.builder(
              itemCount: homeVM.reelList.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: _testimonialCard(homeVM.reelList[index].toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _testimonialCard(String imageUrl) {
    return Stack(
      children: [
        // Thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Opacity(
            opacity: 0.85,
            child: CachedNetworkImage(
              height: 160.0,
              width: 110.0,
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              placeholder: (context, url) =>
                  Container(width: 110, height: 160, color: lavenderMist),
              errorWidget: (context, url, error) =>
                  Container(width: 110, height: 160, color: lavenderMist),
            ),
          ),
        ),

        // Play button overlay
        SizedBox(
          height: 160.0,
          width: 110.0,
          child: Center(
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: white.withOpacity(0.85),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: midnightBlue,
                size: 22,
              ),
            ),
          ),
        ),

        // Bottom gradient label
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  midnightBlue.withOpacity(0.75),
                  Colors.transparent,
                ],
              ),
            ),
            padding: const EdgeInsets.all(6),
            child: Text(
              'Lorem ipsum',
              style: fontRegular.copyWith(color: white, fontSize: fontSize10),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  // ────────────────────────────────────────────
  // Achievements Section
  // ────────────────────────────────────────────
  Widget _achievementsSection(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Rounded lavender container
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: lavenderMist,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              bottom: paddingSize30,
              left: paddingSize20,
              right: paddingSize20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Achievement badges — zigzag layout
                _achievementBadges(),

                const SizedBox(height: paddingSize40),

                // Partners section
                _partners(),

                const SizedBox(height: paddingSize30),

                // Become member button
                CommonButton(
                  fontSize: fontSize16,
                  bgColor: midnightBlue,
                  buttonText: 'become_member'.tr,
                  onPressed: () {
                    Get.toNamed(Routes.getWebViewPageRoute(queryWebUrl));
                  },
                  textColor: periwinkle,
                ),

                const SizedBox(height: paddingSize20),
              ],
            ),
          ),
        ),

        // "Dhiyodha Achievement" pill — floats above rounded container
        Positioned(
          top: -18,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize20, vertical: paddingSize8),
              decoration: BoxDecoration(
                color: bluishPurple,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'achievements'.tr,
                style:
                fontMedium.copyWith(color: white, fontSize: fontSize14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Zigzag achievement badge row ──
  Widget _achievementBadges() {
    final List<Map<String, dynamic>> badges = [
      {'value': '3000+', 'label': 'project_seller'.tr,  'down': false},
      {'value': '5000+', 'label': 'service_seller'.tr,  'down': true},
      {'value': '4000+', 'label': 'skill_seller'.tr,    'down': false},
      {'value': '2000+', 'label': 'mentors_seller'.tr,  'down': true},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: badges.map((badge) {
        return Padding(
          padding: EdgeInsets.only(top: badge['down'] == true ? 30.0 : 0.0),
          child: _badgeTag(
            value: badge['value'] as String,
            label: badge['label'] as String,
          ),
        );
      }).toList(),
    );
  }

  // ── Single badge tag (uses achievementBg asset) ──
  Widget _badgeTag({required String value, required String label}) {
    return Stack(
      children: [
        Image.asset(
          achievementBg,
          height: 90.0,
          width: 70.0,
        ),
        Positioned(
          top: 34.0,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style: fontBold.copyWith(color: white, fontSize: fontSize14),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                textAlign: TextAlign.center,
                style: fontRegular.copyWith(
                    color: spunPearl, fontSize: fontSize10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ────────────────────────────────────────────
  // Partners — LayoutBuilder fixes overflow
  // ────────────────────────────────────────────
  Widget _partners() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'partners'.tr,
              style: fontRegular.copyWith(
                  color: midnightBlue, fontSize: fontSize14),
            ),
            const SizedBox(width: paddingSize10),
            const Expanded(child: Divider(color: midnightBlue)),
          ],
        ),
        const SizedBox(height: paddingSize15),

        LayoutBuilder(
          builder: (context, constraints) {
            const double gap = 8.0;
            final double boxSize = (constraints.maxWidth - gap * 4) / 5;

            List<Widget> buildRow() => List.generate(
              5,
                  (_) => _partnerBox(boxSize),
            );

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buildRow(),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buildRow(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _partnerBox(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(radius10),
      ),
      child: Center(
        child: Image.asset(
          partners,
          height: size * 0.55,
          width: size * 0.55,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}