import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/response_model/referral_response_model.dart';
import '../../utils/helper/routes.dart';
import '../../utils/resource/app_colors.dart';
import '../../utils/resource/app_dimensions.dart';
import '../../utils/resource/app_font_size.dart';
import '../../utils/resource/app_media_assets.dart';
import '../../view/widgets/common_app_bar.dart';
import '../../viewModel/home_viewmodel.dart';

class ReferralsPage extends StatefulWidget {
  @override
  ReferralsPageState createState() => ReferralsPageState();
}

class ReferralsPageState extends State<ReferralsPage> {
  final RxMap<int, bool> _expandedMap = <int, bool>{}.obs;

  final RxBool isGivenTab = true.obs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getReferralData();
    });
  }

  Future<void> getReferralData() async {
    final homeVM = Get.find<HomeViewModel>();

    await homeVM.dashboardData(homeVM.selectedDuration);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeViewModel>(builder: (homeVM) {
        return WillPopScope(
          onWillPop: () async {
            Get.back(result: true);
            return false;
          },
          child: Scaffold(
            backgroundColor: const Color(0xFFF4F6FB),
            appBar: CommonAppBar(
              title: Text(
                "Referrals".tr,
                style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: bluishPurple,
              onPressed: () async {
                final result = await Get.toNamed(Routes.getAddSlipPageRoute());

                if (result == true) {
                  await getReferralData();
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
            body: Column(
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
                  child: homeVM.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Obx(() {
                          return isGivenTab.value
                              ? _buildList(homeVM.referralGivenList)
                              : _buildList(homeVM.referralReceivedList);
                        }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE3E8F4),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() {
        return Row(
          children: [
            _tabPill(
              label: "Given",
              isActive: isGivenTab.value,
              onTap: () async {
                isGivenTab.value = true;
                await getReferralData();
              },
            ),
            _tabPill(
              label: "Received",
              isActive: !isGivenTab.value,
              onTap: () async {
                isGivenTab.value = false;
                await getReferralData();
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? midnightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: midnightBlue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: fontRegular.copyWith(
                color: isActive ? white : const Color(0xFF6B7BA4),
                fontSize: fontSize14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<ReferralChildData> list) {
    if (list.isEmpty) {
      return const Center(child: Text("No Data"));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _referralCard(index, list);
      },
    );
  }

  Widget _referralCard(int index, List<ReferralChildData> list) {
    final data = list[index];
    final String fullName =
        '${data.referralTo?.firstName ?? ""} ${data.referralTo?.lastName ?? ""}'
            .trim();

    return Obx(() {
      final bool isExpanded = _expandedMap[index] ?? false;

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
              InkWell(
                onTap: () {
                  _expandedMap[index] = !isExpanded;
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Row(
                    children: [
                      _profileAvatar(data.referralTo?.profileUrl ?? ""),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(fullName,
                                style: fontBold.copyWith(
                                  fontSize: fontSize16,
                                  color: midnightBlue,
                                  letterSpacing: 0.1,
                                )),
                            const SizedBox(height: 5),
                            _typeBadge(data.type ?? ""),
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
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
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

  Widget _typeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F0FE), Color(0xFFD6E4FF)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: midnightBlue.withOpacity(0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.label_outline_rounded,
              size: 13, color: midnightBlue.withOpacity(0.7)),
          const SizedBox(width: 4),
          Text(
            type.isNotEmpty ? type : '—',
            style: fontMedium.copyWith(fontSize: 12, color: midnightBlue),
          ),
        ],
      ),
    );
  }

  Widget _expandedDetails(ReferralChildData data) {
    return Column(
      children: [
        const Divider(height: 1, thickness: 1, color: Color(0xFFEAEEF8)),
        _detailRow(
          assetPath: referralsBlue,
          label: 'Referral Type',
          value: data.referralType ?? '—',
        ),
        _divider(),
        _detailRow(
          assetPath: meeting,
          label: 'Referral Status',
          value: data.referralStatus ?? '—',
        ),
        _divider(),
        _detailRow(
          assetPath: contact,
          label: 'Contact Number',
          value: data.telephone ?? '—',
        ),
        _divider(),
        _detailRow(
          assetPath: company,
          label: 'Company Name',
          value: data.companyName ?? '-',
        ),
        _detailRow(
          assetPath: postComment,
          label: 'Comments',
          value: data.comments ?? '—',
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
          // Asset icon container
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: midnightBlue.withOpacity(0.08),
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
      const Divider(height: 1, thickness: 1, color: Color(0xFFF0F3FA));
}
