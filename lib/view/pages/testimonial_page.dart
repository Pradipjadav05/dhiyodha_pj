import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/viewModel/testimonial_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewModel/home_viewmodel.dart';

class TestimonialPage extends StatefulWidget {
  TestimonialPageState createState() => TestimonialPageState();
}

class TestimonialPageState extends State<TestimonialPage> {

  final RxBool isSenderTab = true.obs;

  late TestimonialViewModel testimonialVM;
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      testimonialVM = Get.find<TestimonialViewModel>();
      testimonialVM.initData();

      getTestimonialData();
    });
  }

  Future<void> getTestimonialData() async {
    final homeVM = Get.find<HomeViewModel>();

    await homeVM.dashboardData(homeVM.selectedDuration);

    testimonialVM.setDashboardTestimonials(
        homeVM.lastMonthlyData ?? {});
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(builder: (homeVM) {
      return Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            isSenderTab.value
                ? "Testimonials Sent"
                : "Testimonials Received",
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Visibility(
                visible: homeVM.isLoading,
                child: LinearProgressIndicator(
                  color: midnightBlue,
                  backgroundColor: lavenderMist,
                  borderRadius: BorderRadius.circular(radius20),
                ),
              ),
              _buildTabSwitcher(),
              
              Expanded(
                child: Obx(() {
              
                  final list = isSenderTab.value
                      ? testimonialVM.testimonialSenderList
                      : testimonialVM.testimonialReceiverList;
              
                  if (list.isEmpty) {
                    return Center(child: Text("no_test_found".tr));
                  }
              
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return _testimonialListItems(index, list, testimonialVM);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE3E8F4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Obx(() {
        return Row(
          children: [
            _tabPill(
              label: "Sender",
              isActive: isSenderTab.value,
              onTap: () async {
                isSenderTab.value = true;
                await getTestimonialData();
              },
            ),
            _tabPill(
              label: "Receiver",
              isActive: !isSenderTab.value,
              onTap: () async {
                isSenderTab.value = false;
                await getTestimonialData();
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _tabPill({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? midnightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _testimonialListItems(
      int index,
      List list,
      TestimonialViewModel testimonialVM) {

    final data = list[index];

    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: ListTile(
        contentPadding: EdgeInsets.all(paddingSize10),
        onTap: () async {
          Get.toNamed(Routes.getTestimonialDetailsPageRoute(data))
              ?.then((result) {
            if (result == true) {
              showSnackBar("testimonials_deleted".tr, isError: false);
            }
          });
        },
        leading: _profileAvatar(data.reviewerPofileUrl ?? ""),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${data.reviewerFirstName} ${data.reviewerLastName}',
              style:
              fontBold.copyWith(color: midnightBlue, fontSize: fontSize18),
            ),
            Text(
              '${data.type}',
              style: fontMedium.copyWith(color: greyText, fontSize: fontSize12),
            ),
            SizedBox(height: paddingSize5),
            Text(
              '${data.companyName}',
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

  Widget _profileAvatar(String? profileUrl) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: midnightBlue.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: profileUrl != null && profileUrl.isNotEmpty
            ? CachedNetworkImage(
          imageUrl: profileUrl,
          width: 58,
          height: 58,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => _avatarFallback(),
        )
            : _avatarFallback(),
      ),
    );
  }

  Widget _avatarFallback() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [midnightBlue, const Color(0xFF4A6FA5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipOval(
        child: Icon(Icons.person, color: Colors.white),
      ),
    );
  }
}