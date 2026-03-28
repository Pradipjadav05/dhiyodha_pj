import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhiyodha/model/response_model/one_to_one_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/viewModel/one_to_one_slip_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OneToOnePage extends StatefulWidget {
  const OneToOnePage({Key? key}) : super(key: key);

  @override
  OneToOnePageState createState() => OneToOnePageState();
}

class OneToOnePageState extends State<OneToOnePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  final Map<int, bool> _expandedMap = {};

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await Get.find<OneToOneSlipViewModel>()
        .getOneToOneData(0, 100, 'createdAt', 'DESC');
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<OneToOneSlipViewModel>(builder: (oVM) {
        return Scaffold(
          backgroundColor: const Color(0xFFF4F6FB),
          appBar: CommonAppBar(
            title: Text(
              "One-to-One Slip".tr,
              style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          floatingActionButton: _buildFAB(),
          body: FadeTransition(
            opacity: _fadeAnim,
            child: oVM.isLoading
                ? Center(
              child: CircularProgressIndicator(color: midnightBlue),
            )
                : oVM.oneToOneDataList.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              itemCount: oVM.oneToOneDataList.length,
              itemBuilder: (context, index) {
                return _oneToOneCard(index, oVM);
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      tooltip: "Add One-to-One",
      elevation: 6,
      backgroundColor: bluishPurple,
      onPressed: () async {
        await Get.toNamed(Routes.getAddOneToOnePageRoute());
        await _fetchData();
      },
      child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline_rounded,
              size: 72, color: bluishPurple.withOpacity(0.18)),
          const SizedBox(height: 14),
          Text(
            'No records found',
            style: fontMedium.copyWith(color: greyText, fontSize: fontSize16),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap + to add your first One-to-One',
            style: fontRegular.copyWith(
                color: greyText.withOpacity(0.7), fontSize: fontSize13),
          ),
        ],
      ),
    );
  }

  Widget _oneToOneCard(int index, OneToOneSlipViewModel oVM) {
    final OneToOneChildData data = oVM.oneToOneDataList[index];
    final bool isExpanded = _expandedMap[index] ?? false;

    final String connectedWithName =
    '${data.connectedWith?.firstName ?? ''} ${data.connectedWith?.lastName ?? ''}'
        .trim();
    final String initiatedByName =
    '${data.initiatedBy?.firstName ?? ''} ${data.initiatedBy?.lastName ?? ''}'
        .trim();
    final String mobileNo = data.connectedWith?.mobileNo ?? '';
    final String notes = data.oneToOneNotes ?? '';
    final String date = data.oneToOneDate ?? '';
    final String? profileUrl = data.connectedWith?.profileUrl;

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
            // ── Header row ──
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
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    // ── Circular profile image ──
                    _profileAvatar(profileUrl),
                    const SizedBox(width: 14),

                    // ── Name + date badge ──
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            connectedWithName.isNotEmpty
                                ? connectedWithName
                                : 'Unknown',
                            style: fontBold.copyWith(
                              fontSize: fontSize16,
                              color: midnightBlue,
                              letterSpacing: 0.1,
                            ),
                          ),
                          const SizedBox(height: 5),
                          _dateBadge(date),
                        ],
                      ),
                    ),

                    // ── Expand / collapse arrow ──
                    Image.asset(
                      isExpanded ? nextArrow : dropDownArrow,
                      height: iconSize18,
                      width: iconSize18,
                        color: midnightBlue
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
              secondChild: _expandedDetails(
                data: data,
                mobileNo: mobileNo,
                initiatedByName: initiatedByName,
                notes: notes,
                connectedWithName: connectedWithName,
              ),
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

  Widget _dateBadge(String date) {
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
          Icon(Icons.calendar_today_outlined,
              size: 13, color: midnightBlue.withOpacity(0.7)),
          const SizedBox(width: 4),
          Text(
            date.isNotEmpty ? date : '—',
            style: fontMedium.copyWith(fontSize: 12, color: midnightBlue),
          ),
        ],
      ),
    );
  }

  Widget _expandedDetails({
    required OneToOneChildData data,
    required String mobileNo,
    required String initiatedByName,
    required String notes,
    required String connectedWithName,
  }) {
    return Column(
      children: [
        const Divider(height: 1, thickness: 1, color: Color(0xFFEAEEF8)),
        _detailRow(
          assetPath: contact,
          label: 'Contact Number',
          value: mobileNo,
        ),
        _divider(),
        _detailRow(
          assetPath: company,
          label: 'Initiated By',
          value: initiatedByName,
        ),
        _divider(),
        _detailRow(
          assetPath: businessCat,
          label: 'Notes',
          value: notes,
        ),
        _divider(),
        _detailRowTappable(
          assetPath: vCard,
          label: 'V-Card',
          value: connectedWithName,
          onTap: () {
            // TODO: handle V-Card tap
          },
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
                          value.isEmpty ? '—' : value,
                          style: fontMedium.copyWith(
                            fontSize: fontSize14,
                            color: midnightBlue,
                          ),
                        ),
                      ),
                      Icon(Icons.open_in_new_rounded,
                          size: 14, color: midnightBlue.withOpacity(0.4)),
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
        color: bluishPurple.withOpacity(0.08),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Center(
        child: Image.asset(assetPath, height: iconSize18, width: iconSize18,  color: bluishPurple),
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
            value.isEmpty ? '—' : value,
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
      const Divider(height: 1, thickness: 1, color: Color(0xFFF0F3FA));
}