import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhiyodha/model/response_model/tyfcb_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/viewModel/tyfcb_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TyfcbPage extends StatefulWidget {
  @override
  TyfcbPageState createState() => TyfcbPageState();
}

class TyfcbPageState extends State<TyfcbPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  // Track each tile's expansion independently
  final Map<int, bool> _expandedMap = {};

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
    callInitData();
  }

  Future<void> callInitData() async {
    TyfcbViewModel tyfcbViewModel = Get.find<TyfcbViewModel>();
    await tyfcbViewModel.initData();
    await tyfcbViewModel.getTyfcbData(
        tyfcbViewModel.page.value, tyfcbViewModel.size.value, "", "", "");
  }

  Future<void> getTyfcbData(
      int page, int size, String? sort, String? orderBy, String? search) async {
    await Get.find<TyfcbViewModel>()
        .getTyfcbData(page, size, sort, orderBy, search);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<TyfcbViewModel>(builder: (tyVM) {
        return Scaffold(
          backgroundColor: const Color(0xFFF4F6FB),
          appBar: CommonAppBar(
            title: Text(
              "TYFCBs".tr,
              style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          floatingActionButton: _buildFAB(tyVM),
          body: FadeTransition(
            opacity: _fadeAnim,
            child: tyVM.tyfcbList.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              itemCount: tyVM.tyfcbList.length,
              itemBuilder: (context, index) {
                return _tyfcbCard(index, tyVM);
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFAB(TyfcbViewModel tyVM) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      tooltip: "Add TYFCBs",
      elevation: 6,
      backgroundColor: bluishPurple,
      onPressed: () async {
        await Get.toNamed(Routes.getAddTyPageRoute());
        await getTyfcbData(0, 10, "", "", "");
      },
      child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.handshake_outlined,
              size: 72, color: bluishPurple.withOpacity(0.18)),
          const SizedBox(height: 14),
          Text(
            'No TYFCBs yet',
            style: fontMedium.copyWith(
                color: greyText, fontSize: fontSize16),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap + to add your first TYFCB',
            style: fontRegular.copyWith(
                color: greyText.withOpacity(0.7), fontSize: fontSize13),
          ),
        ],
      ),
    );
  }

  Widget _tyfcbCard(int index, TyfcbViewModel tyVM) {
    final TyfcbChildData tyfcbData = tyVM.tyfcbList[index];
    final bool isExpanded = _expandedMap[index] ?? false;
    final String fullName =
    '${tyfcbData.recipient?.firstName ?? ""} ${tyfcbData.recipient?.lastName ?? ""}'.trim();
    final String? profileUrl = tyfcbData.recipient?.profileUrl;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A5F).withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFEAEEF8), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [
            // ── Header row (always visible) ──
            InkWell(
              onTap: () => setState(() {
                _expandedMap[index] = !isExpanded;
              }),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isExpanded ? 0 : 18),
                bottomRight: Radius.circular(isExpanded ? 0 : 18),
              ),
              splashColor: lavenderMist.withOpacity(0.4),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    // ── Circular profile image ──
                    _profileAvatar(profileUrl),
                    const SizedBox(width: 14),

                    // ── Name + gift amount ──
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName.isNotEmpty ? fullName : 'Unknown',
                            style: fontBold.copyWith(
                              fontSize: fontSize16,
                              color: midnightBlue,
                              letterSpacing: 0.1,
                            ),
                          ),
                          const SizedBox(height: 5),
                          _giftAmountBadge((tyfcbData.giftAmount ?? '0.0').toString()),
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
              secondChild: _expandedDetails(tyfcbData),
            ),
          ],
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
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [midnightBlue, const Color(0xFF4A6FA5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipOval(
        child: Image.asset(profileImage,
            width: 58, height: 58, fit: BoxFit.cover),
      ),
    );
  }

  Widget _giftAmountBadge(String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFE8F0FE),
            const Color(0xFFD6E4FF),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: midnightBlue.withOpacity(0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.card_giftcard_rounded,
              size: 13, color: midnightBlue.withOpacity(0.7)),
          const SizedBox(width: 4),
          Text(
            'Gift: ₹$amount',
            style: fontMedium.copyWith(
              fontSize: 12,
              color: midnightBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _expandedDetails(TyfcbChildData tyfcbData) {
    return Column(
      children: [
        Divider(height: 1, thickness: 1, color: const Color(0xFFEAEEF8)),
        // _detailRow(
        //   assetPath: meeting,
        //   assetColor: midnightBlue,
        //   label: 'Status',
        //   value: tyfcbData.meetingDetails?.status ?? '—',
        // ),
        // _divider(),
        _detailRow(
          assetPath: company,
          label: 'Business Type',
          value: tyfcbData.businessType ?? '—',
          assetColor: bluishPurple,
        ),
        _divider(),
        _detailRow(
          assetPath: referralsBlue,
          label: 'Referral Type',
          value: tyfcbData.referralType ?? '—',
          assetColor: bluishPurple,
        ),
        _divider(),
        _detailRow(
          assetPath: postComment,
          assetColor: bluishPurple,
          label: 'Comments',
          value: tyfcbData.comments ?? '—',
        ),
      ],
    );
  }

  Widget _detailRow({
    required String assetPath,
    Color? assetColor,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Asset icon container
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: (assetColor ?? midnightBlue).withOpacity(0.08),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
              child: Image.asset(
                assetPath,
                height: iconSize18,
                width: iconSize18,
                color: assetColor,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Label + value
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
                Text(
                  value,
                  style: fontMedium.copyWith(
                    fontSize: fontSize14,
                    color: midnightBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Divider(height: 1, thickness: 1, color: const Color(0xFFF0F3FA));
}