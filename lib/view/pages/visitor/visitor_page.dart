import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhiyodha/model/response_model/visitor_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/pages/attendance_scanner_page.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/attendance_success_dialog.dart';
import 'package:dhiyodha/viewModel/visitors_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

import '../../../viewModel/home_viewmodel.dart';
import '../../widgets/common_snackbar.dart';

class VisitorPage extends StatefulWidget {
  final bool isAppBarRequired;
  final VoidCallback onStateChanged;

  const VisitorPage({
    Key? key,
    required this.isAppBarRequired,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  VisitorPageState createState() => VisitorPageState();
}

class VisitorPageState extends State<VisitorPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  final RxBool _isMarkingAttendance = false.obs;

  final RxMap<int, bool> _expandedMap = <int, bool>{}.obs;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
    setupInitialData();
  }

  Future<void> setupInitialData() async {
    final visitorVM = Get.find<VisitorsViewModel>();
    final homeVM = Get.find<HomeViewModel>();

    await visitorVM.initData();
    // await vvm.getVisitors(vvm.page.value, vvm.size.value, "", "", "");

    await homeVM.dashboardData(homeVM.selectedDuration);

    visitorVM.setDashboardVisitors(homeVM.lastMonthlyData ?? {});
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Widget _buildFAB(VisitorsViewModel visitorVM) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      tooltip: "add_visitor".tr,
      elevation: 6,
      backgroundColor: bluishPurple,
      onPressed: () async {
        if (widget.isAppBarRequired) {
          await Get.toNamed(Routes.getAddVisitorPageRoute());
          await setupInitialData();
        } else {
          widget.onStateChanged();
        }
      },
      child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_add_alt_outlined,
              size: 72, color: bluishPurple.withValues(alpha: 0.18)),
          const SizedBox(height: 14),
          Text(
            'no_visitors'.tr,
            style: fontMedium.copyWith(color: greyText, fontSize: fontSize16),
          ),
          const SizedBox(height: 6),
          Text(
            "tap_to_add_first_visitor".tr,
            style: fontRegular.copyWith(
                color: greyText.withValues(alpha: 0.7), fontSize: fontSize13),
          ),
        ],
      ),
    );
  }

  Widget _visitorCard(int index, VisitorsViewModel visitorVM) {
    final VisitorChildData data = visitorVM.visitorData[index];

    return Obx(() {
      final bool isExpanded = _expandedMap[index] ?? false;
      final String? profileUrl = data.profileUrl;

      return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
                color: visitorAccent.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: visitorCardBorder, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [
            // ── Header row ──
            InkWell(
              onTap: () {
                _expandedMap[index] = !isExpanded;
              },
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isExpanded ? 0 : 18),
                bottomRight: Radius.circular(isExpanded ? 0 : 18),
              ),
              splashColor: lavenderMist.withValues(alpha: 0.4),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    // ── Circular profile image ──
                    _profileAvatar(profileUrl ?? ""),
                    const SizedBox(width: 14),

                    // ── Name + title badge ──
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name ?? '',
                            style: fontBold.copyWith(
                              fontSize: fontSize16,
                              color: midnightBlue,
                              letterSpacing: 0.1,
                            ),
                          ),
                          const SizedBox(height: 5),
                          if (data.designation != "" &&
                              data.designation != null)
                            _titleBadge(data.designation ?? ''),
                        ],
                      ),
                    ),

                    // ── Expand / collapse arrow ──
                    Image.asset(
                      isExpanded ? nextArrow : dropDownArrow,
                      height: iconSize18,
                      width: iconSize18,
                      color: bluishPurple,
                    ),
                  ],
                ),
              ),
            ),

            // ── Expandable detail rows ──
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 280),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: _expandedDetails(data),
            ),
          ],
        ),
      ),
      );
    });
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
            color: midnightBlue.withValues(alpha: 0.15),
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
          colors: [midnightBlue, visitorAccentSoft],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipOval(
        child: Icon(Icons.person, color: Colors.white),
      ),
    );
  }

  Widget _titleBadge(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [visitorSoftStart, visitorSoftEnd],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: midnightBlue.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.work_outline_rounded,
              size: 13, color: midnightBlue.withValues(alpha: 0.7)),
          const SizedBox(width: 4),
          Text(
            title.isNotEmpty ? title : '',
            style: fontMedium.copyWith(fontSize: 12, color: midnightBlue),
          ),
        ],
      ),
    );
  }

  Widget _expandedDetails(VisitorChildData data) {
    return Column(
      children: [
        const Divider(height: 1, thickness: 1, color: visitorCardBorder),
        _detailRow(
          assetPath: meeting,
          label: "meeting_chapter_name".tr,
          value: data.chapterName?.toString() ?? '—',
        ),
        _detailRow(
          assetPath: contact,
          label: 'contact_number'.tr,
          value: data.contactNumber?.toString() ?? '—',
        ),
        _divider(),
        _detailRow(
          assetPath: company,
          label: 'company_name'.tr,
          value: data.companyName ?? '—',
        ),
        _divider(),
        _detailRow(
          assetPath: businessCat,
          label: 'business_category'.tr,
          value: data.businessCategory ?? '—',
        ),
        _divider(),
        _detailRowTappable(
          assetPath: vCard,
          label: 'v_card'.tr,
          value: data.name ?? '—',
          onTap: () {
            Get.toNamed(Routes.getVisitingCardPageRoute(visitorData: data));
          },
        ),
        _divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,),
          child: SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: brandNavy,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: scannerPurple.withValues(alpha: 0.35),
                    blurRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: brandNavy.withValues(alpha: 0.28),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () async {
                  if (_isMarkingAttendance.value) {
                    return;
                  }

                  final String visitorUuid = (data.uuId ?? '').trim();
                  if (visitorUuid.isEmpty) {
                    showSnackBar("visitor_uuid_not_found".tr);
                    return;
                  }

                  _isMarkingAttendance.value = true;

                  try {
                    final String? scannedValue = await Get.to<String>(
                      () => const AttendanceScannerPage(),
                    );

                    if (scannedValue == null || scannedValue.isEmpty) {
                      showSnackBar("scan_qr_code_message".tr);
                      return;
                    }

                    final String? qrToken = _extractQrToken(scannedValue);
                    if (qrToken == null || qrToken.isEmpty) {
                      showSnackBar("invalid_qr_message".tr);
                      return;
                    }

                    final Position? currentPosition =
                        await _getCurrentPosition();
                    if (currentPosition == null) {
                      return;
                    }

                    final bool isMarked =
                        await Get.find<VisitorsViewModel>().markVisitorAttendance(
                      qrToken: qrToken,
                      visitorUuid: visitorUuid,
                      latitude: currentPosition.latitude,
                      longitude: currentPosition.longitude,
                    );

                    if (!mounted || !isMarked) {
                      return;
                    }

                    await showAttendanceSuccessDialog(
                      context,
                      visitorName: data.name,
                    );
                  } finally {
                    _isMarkingAttendance.value = false;
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: scannerPurple,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "mark_attendance".tr,
                      style: fontMedium.copyWith(
                        color: ghostWhite,
                        fontSize: fontSize16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _detailRow({
    required String assetPath,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconContainer(assetPath),
          const SizedBox(width: 12),
          _labelValue(label, value),
        ],
      ),
    );
  }

  Widget _detailRowTappable({
    required String assetPath,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _iconContainer(assetPath),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: fontRegular.copyWith(
                      fontSize: 11,
                      color: greyText,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          value,
                          style: fontMedium.copyWith(
                            fontSize: fontSize14,
                            color: midnightBlue,
                          ),
                        ),
                      ),
                      Icon(Icons.open_in_new_rounded,
                          size: 14, color: midnightBlue.withValues(alpha: 0.4)),
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

  Widget _iconContainer(String assetPath) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: bluishPurple.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          height: iconSize18,
          width: iconSize18,
          color: bluishPurple,
        ),
      ),
    );
  }

  Widget _labelValue(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: fontRegular.copyWith(
              fontSize: 11,
              color: greyText,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: fontMedium.copyWith(
              fontSize: fontSize14,
              color: midnightBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      const Divider(height: 1, thickness: 1, color: screenDivider);

  String? _extractQrToken(String rawValue) {
    final RegExpMatch? match =
        RegExp(r'token=([A-Za-z0-9-]+)').firstMatch(rawValue.trim());
    return match?.group(1);
  }

  Future<Position?> _getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      showSnackBar("Location permission denied");
      return null;
    }

    return Geolocator.getCurrentPosition(
      locationSettings:
          const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VisitorsViewModel>(builder: (visitorVM) {
      return Obx(() {
        final bool isBusy =
            _isMarkingAttendance.value || visitorVM.isLoading;
    
        return Scaffold(
          backgroundColor: pageBackground,
          appBar: widget.isAppBarRequired
              ? CommonAppBar(
                  title: Text(
                    "visitors".tr,
                    style: fontBold.copyWith(
                      fontSize: fontSize18,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                )
              : null,
          floatingActionButton: _buildFAB(visitorVM),
          body: SafeArea(
            child: Stack(
              children: [
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    children: [
                      if (visitorVM.isLoading)
                        LinearProgressIndicator(
                          color: midnightBlue,
                          backgroundColor: lavenderMist,
                          minHeight: 3,
                          borderRadius: BorderRadius.circular(radius20),
                        ),
                
                      visitorVM.visitorData.isNotEmpty
                          ? Expanded(
                              child: LoadMore(
                                isFinish: visitorVM.page.value ==
                                    visitorVM.totalPages.value,
                                whenEmptyLoad: true,
                                delegate: const DefaultLoadMoreDelegate(),
                                textBuilder: DefaultLoadMoreTextBuilder.english,
                                onLoadMore: visitorVM.loadMore,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.fromLTRB(
                                      16, 12, 16, 100),
                                  itemCount: visitorVM.visitorData.length,
                                  itemBuilder: (context, index) {
                                    return _visitorCard(index, visitorVM);
                                  },
                                ),
                              ),
                            )
                          : Expanded(child: _buildEmptyState()),
                    ],
                  ),
                ),
                if (isBusy)
                  Positioned.fill(
                    child: ColoredBox(
                      color: Colors.transparent,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      });
    });
  }
}
