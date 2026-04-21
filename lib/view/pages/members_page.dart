import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:dhiyodha/model/response_model/world_wide_search_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/members_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

class MembersPage extends StatefulWidget {
  final String isReturnResult;

  const MembersPage({Key? key, required this.isReturnResult}) : super(key: key);

  @override
  MembersPageState createState() => MembersPageState();
}

class MembersPageState extends State<MembersPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _chapterController = TextEditingController();
  final TextEditingController _businessCatController = TextEditingController();

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
    _initData();
  }

  Future<void> _initData() async {
    await Get.find<MembersViewmodel>().initData();
    _resetAutocompleteControllers();
  }

  void _resetAutocompleteControllers() {
    _countryController.text = '';
    _stateController.text = '';
    _cityController.text = '';
    _chapterController.text = '';
    _businessCatController.text = '';
  }

  @override
  void dispose() {
    _animController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _chapterController.dispose();
    _businessCatController.dispose();
    super.dispose();
  }

  MembersChildData _toMembersChildData(WorldWideMembers w) {
    return MembersChildData.fromJson(w.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembersViewmodel>(builder: (membersVM) {
      return Scaffold(
        backgroundColor: const Color(0xFFF4F6FB),
        appBar: CommonAppBar(
          title: Text(
            'members'.tr,
            style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => FadeTransition(
              opacity: _fadeAnim,
              child: Column(
                children: [
                  // ── Loading bar ──
                  if (membersVM.isLoading)
                    LinearProgressIndicator(
                      color: midnightBlue,
                      backgroundColor: lavenderMist,
                      minHeight: 3,
                      borderRadius: BorderRadius.circular(radius20),
                    ),
              
                  // ── Tab switcher ──
                  _buildTabSwitcher(membersVM),
              
                  // ── Body ──
                  if (membersVM.isChapterRoster.value)
                    Expanded(child: _buildChapterRosterTab(membersVM))
                  else
                    Expanded(child: _buildWorldWideTab(membersVM)),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // ── Pill-style tab switcher ──
  Widget _buildTabSwitcher(MembersViewmodel membersVM) {
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
      child: Row(
        children: [
          _tabPill(
            label: 'chapter_roaster'.tr,
            isActive: membersVM.isChapterRoster.value,
            onTap: () {
              membersVM.isChapterRoster.value = true;
              membersVM.isWorldWide.value = false;
              membersVM.isWorldWideListShow.value = false;
              membersVM.worldWiseMembersData = [];
            },
          ),
          _tabPill(
            label: 'worldwide_search'.tr,
            isActive: membersVM.isWorldWide.value,
            onTap: () async {
              membersVM.isChapterRoster.value = false;
              membersVM.isWorldWide.value = true;
              membersVM.isWorldWideListShow.value = false;
              membersVM.worldWiseMembersData = [];
              _resetAutocompleteControllers();
              await membersVM.getGroups(0, membersVM.size.value, '', '', '');
              await membersVM.getCountries();
              await membersVM.getBusinessCategories();
            },
          ),
        ],
      ),
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
          curve: Curves.easeInOut,
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
              overflow: TextOverflow.ellipsis,
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

  // ── Chapter Roster Tab ──
  Widget _buildChapterRosterTab(MembersViewmodel membersVM) {
    return Column(
      children: [
        // ── Search bar ──
        _buildSearchBar(membersVM),

        // ── Member list ──
        Expanded(
          child: LoadMore(
            isFinish: membersVM.page.value == membersVM.totalPages.value,
            whenEmptyLoad: true,
            delegate: const DefaultLoadMoreDelegate(),
            textBuilder: DefaultLoadMoreTextBuilder.english,
            onLoadMore: membersVM.loadMore,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              itemCount: membersVM.membersData.length,
              itemBuilder: (context, index) {
                return _chapterRosterItem(index, membersVM);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(MembersViewmodel membersVM) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A5F).withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE3E8F4), width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded,
              color: midnightBlue.withOpacity(0.5), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: membersVM.memberSearchController,
              style: fontMedium.copyWith(
                  color: midnightBlue, fontSize: fontSize14),
              decoration: InputDecoration(
                hintText: 'search_member'.tr,
                hintStyle: fontRegular.copyWith(
                    color: midnightBlue.withOpacity(0.4), fontSize: fontSize14),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: (value) async {
                if (value.isNotEmpty) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce =
                      Timer(const Duration(milliseconds: 700), () async {
                    await membersVM.searchType('GLOBAL', value);
                  });
                } else {
                  membersVM.memberSearchController.text = '';
                  membersVM.page.value = 0;
                  membersVM.totalPages.value = 0;
                  membersVM.membersData = [];
                  await membersVM.getUsersOrMembers(
                      0, membersVM.size.value, '', '', '');
                }
              },
            ),
          ),
          // Search action
          // _iconButton(
          //   assetPath: searchBlue,
          //   size: 22,
          //   onTap: () async {
          //     if (membersVM.memberSearchController.text.isEmpty) {
          //       showSnackBar('member_name_search'.tr);
          //     } else {
          //       await membersVM.searchType(
          //           'GLOBAL', membersVM.memberSearchController.text);
          //     }
          //   },
          // ),
          const SizedBox(width: 6),
          // Reload action
          _iconButton(
            assetPath: reload,
            size: 24,
            onTap: () async {
              membersVM.memberSearchController.text = '';
              membersVM.page.value = 0;
              membersVM.totalPages.value = 0;
              membersVM.membersData = [];
              await membersVM.getUsersOrMembers(
                  0, membersVM.size.value, '', '', '');
            },
          ),
        ],
      ),
    );
  }

  Widget _iconButton({
    required String assetPath,
    required double size,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Image.asset(assetPath, width: size, height: size),
      ),
    );
  }

  // ── Chapter Roster card item ──
  Widget _chapterRosterItem(int index, MembersViewmodel membersVM) {
    final MembersChildData member = membersVM.membersData[index];
    return _memberCard(
      profileUrl: member.profileUrl,
      name: '${member.firstName} ${member.lastName}',
      businessCategory: member.organization?.businessCategory ?? '',
      companyName: member.organization?.companyName ?? '',
      onTap: () async {
        if (widget.isReturnResult == 'false') {
          await Get.toNamed(Routes.getMembersProfilePageRoute(member));
        } else {
          Get.back(result: member, closeOverlays: true);
        }
      },
      onArrowTap: () async {
        await Get.toNamed(Routes.getMembersProfilePageRoute(member));
      },
      teamName: member.userGroups?.isNotEmpty == true
          ? member.userGroups![0].groupName ?? ""
          : "",
      city: member.address?.city ?? '',
      state: member.address?.state ?? '',
    );
  }

  // ── Worldwide member card item ──
  Widget _worldWideMemberItem(int index, MembersViewmodel membersVM) {
    final WorldWideMembers wwMember = membersVM.worldWiseMembersData[index];
    final MembersChildData member = _toMembersChildData(wwMember);
    return _memberCard(
      profileUrl: wwMember.profileUrl,
      name: '${wwMember.firstName} ${wwMember.lastName}',
      businessCategory: wwMember.organization?.businessCategory ?? '',
      companyName: wwMember.organization?.companyName ?? '',
      onTap: () async {
        if (widget.isReturnResult == 'false') {
          await Get.toNamed(Routes.getMembersProfilePageRoute(member));
        } else {
          Get.back(result: member, closeOverlays: true);
        }
      },
      onArrowTap: () async {
        await Get.toNamed(Routes.getMembersProfilePageRoute(member));
      },
      teamName: member.userGroups != null ? member.userGroups![0].groupName ?? "" : "",
      city: member.address?.city ?? '',
      state: member.address?.state ?? '',
    );
  }

  // ── Shared polished member card ──
  Widget _memberCard({
    required String? profileUrl,
    required String name,
    required String businessCategory,
    required String companyName,
    required String teamName,
    required String city,
    required String state,
    required VoidCallback onTap,
    required VoidCallback onArrowTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A5F).withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFEAEEF8), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: lavenderMist.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Avatar
                _memberAvatar(profileUrl),
                const SizedBox(width: 14),

                // Text info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: fontBold.copyWith(
                          color: midnightBlue,
                          fontSize: fontSize16,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 3),
                      if (businessCategory.isNotEmpty)
                        _infoChip(businessCategory),
                      if (companyName.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.business_outlined,
                                size: 12, color: greyText.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                companyName,
                                overflow: TextOverflow.ellipsis,
                                style: fontRegular.copyWith(
                                    color: greyText, fontSize: fontSize12),
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (teamName.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.groups,
                                size: 12, color: greyText.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                teamName,
                                overflow: TextOverflow.ellipsis,
                                style: fontRegular.copyWith(
                                    color: greyText, fontSize: fontSize12),
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (city.isNotEmpty || state.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 12, color: greyText.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "$city, $state",
                                overflow: TextOverflow.ellipsis,
                                style: fontRegular.copyWith(
                                    color: greyText, fontSize: fontSize12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // Arrow button
                GestureDetector(
                  onTap: onArrowTap,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: midnightBlue.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: bluishPurple,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: lavenderMist,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: fontRegular.copyWith(
          color: midnightBlue.withOpacity(0.75),
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _memberAvatar(String? profileUrl) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: white, width: 2.5),
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
                height: 62.0,
                width: 62.0,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => _placeholderAvatar(),
              )
            : _placeholderAvatar(),
      ),
    );
  }

  Widget _placeholderAvatar() {
    return Container(
      height: 62,
      width: 62,
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

  // ── Worldwide tab ──
  Widget _buildWorldWideTab(MembersViewmodel membersVM) {
    if (membersVM.isWorldWideListShow.value) {
      return membersVM.worldWiseMembersData.isNotEmpty
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: membersVM.worldWiseMembersData.length,
              itemBuilder: (context, index) =>
                  _worldWideMemberItem(index, membersVM),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_search_outlined,
                      size: 64, color: midnightBlue.withOpacity(0.2)),
                  const SizedBox(height: 12),
                  Text(
                    'no_member_found'.tr,
                    style: fontRegular.copyWith(
                        color: greyText, fontSize: fontSize14),
                  ),
                ],
              ),
            );
    }
    return _worldWideSearchForm(membersVM);
  }

  // ── Worldwide search form ──
  Widget _worldWideSearchForm(MembersViewmodel membersVM) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Location section ──
          _sectionHeader('location'.tr),
          const SizedBox(height: 14),

          _autocompleteField(
            label: 'select_country'.tr,
            icon: Icons.public_outlined,
            controller: _countryController,
            options: membersVM.countryList
                .where((c) => c != 'Select Country')
                .toList(),
            onSelected: (val) async {
              membersVM.selectedCountry = val;
              _stateController.clear();
              _cityController.clear();
              membersVM.selectedState = membersVM.stateList.isNotEmpty
                  ? membersVM.stateList[0]
                  : 'Select State';
              membersVM.selectedCity = membersVM.cityList.isNotEmpty
                  ? membersVM.cityList[0]
                  : 'Select City';
              await membersVM.getStates(val);
              membersVM.update();
            },
          ),
          const SizedBox(height: 12),

          _autocompleteField(
            label: 'select_state'.tr,
            icon: Icons.map_outlined,
            controller: _stateController,
            options:
                membersVM.stateList.where((s) => s != 'Select State').toList(),
            onSelected: (val) async {
              membersVM.selectedState = val;
              _cityController.clear();
              membersVM.selectedCity = membersVM.cityList.isNotEmpty
                  ? membersVM.cityList[0]
                  : 'Select City';
              await membersVM.getCities(val);
              membersVM.update();
            },
          ),
          const SizedBox(height: 12),

          _autocompleteField(
            label: 'select_city'.tr,
            icon: Icons.location_city_outlined,
            controller: _cityController,
            options:
                membersVM.cityList.where((c) => c != 'Select City').toList(),
            onSelected: (val) {
              membersVM.selectedCity = val;
              membersVM.update();
            },
          ),
          const SizedBox(height: 12),

          _autocompleteField(
            label: 'select_chapter'.tr,
            icon: Icons.groups_outlined,
            controller: _chapterController,
            options: membersVM.chapterList
                .where((c) => c != 'Select Chapter')
                .toList(),
            onSelected: (val) {
              membersVM.selectedChapter = val;
              membersVM.update();
            },
          ),
          const SizedBox(height: 20),

          // ── Member Details section ──
          _sectionHeader('member_details'.tr),
          const SizedBox(height: 14),

          // Member name
          _styledTextInput(
            controller: membersVM.memberNameController,
            hintText: 'member_name'.tr,
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 12),

          _autocompleteField(
            label: 'select_business_category'.tr,
            icon: Icons.business_center_outlined,
            controller: _businessCatController,
            options: membersVM.businessCatList
                .where((b) => b != membersVM.businessCatList[0])
                .toList(),
            onSelected: (val) {
              membersVM.selectedBusinessCategory = val;
              membersVM.update();
            },
          ),
          const SizedBox(height: 28),

          // Confirm button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await _collectDataAndSearchMember(membersVM);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: bluishPurple,
                foregroundColor: white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
                shadowColor: bluishPurple.withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_rounded, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'confirm'.tr,
                    style:
                        fontBold.copyWith(fontSize: fontSize16, color: white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Styled text input (Member Name) ──
  Widget _styledTextInput({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E8F4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A5F).withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(icon, color: bluishPurple.withOpacity(0.5), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              style: fontRegular.copyWith(
                  color: midnightBlue, fontSize: fontSize14),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: fontRegular.copyWith(
                    color: midnightBlue.withOpacity(0.4), fontSize: fontSize14),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Autocomplete field ──
  Widget _autocompleteField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required List<String> options,
    required void Function(String) onSelected,
  }) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) return options;
        return options.where((o) =>
            o.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (String option) => option,
      onSelected: (String selection) {
        controller.text = selection;
        onSelected(selection);
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        if (controller.text.isEmpty && fieldController.text.isNotEmpty) {
          fieldController.clear();
        }
        return Focus(
          onFocusChange: (hasFocus) =>
              Get.find<MembersViewmodel>().update(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color:
                    focusNode.hasFocus ? midnightBlue : const Color(0xFFE3E8F4),
                width: focusNode.hasFocus ? 1.8 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: focusNode.hasFocus
                      ? midnightBlue.withOpacity(0.1)
                      : const Color(0xFF1E3A5F).withOpacity(0.05),
                  blurRadius: focusNode.hasFocus ? 12 : 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Icon(icon,
                    color: focusNode.hasFocus
                        ? bluishPurple
                        : bluishPurple.withOpacity(0.45),
                    size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: fieldController,
                    focusNode: focusNode,
                    style: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    decoration: InputDecoration(
                      hintText: label,
                      hintStyle: fontRegular.copyWith(
                          color: midnightBlue.withOpacity(0.4),
                          fontSize: fontSize14),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: AnimatedRotation(
                    turns: focusNode.hasFocus ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: bluishPurple.withOpacity(0.6),
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options,
      ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(14),
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE3E8F4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: midnightBlue.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              constraints: const BoxConstraints(maxHeight: 200),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: options.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: const Color(0xFFEAEEF8),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return InkWell(
                      onTap: () => onSelected(option),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: fontRegular.copyWith(
                                    color: bluishPurple, fontSize: fontSize14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Section header ──
  Widget _sectionHeader(String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: bluishPurple,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: fontBold.copyWith(
              color: white,
              fontSize: fontSize13,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  midnightBlue.withOpacity(0.25),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _collectDataAndSearchMember(MembersViewmodel membersVM) async {
    await membersVM.getWorldWideSearchedUsersOrMembers(
      membersVM.selectedCity != 'Select City' &&
              membersVM.selectedCity.toString().isNotEmpty
          ? membersVM.selectedCity
          : '',
      membersVM.selectedState != 'Select State' &&
              membersVM.selectedState.toString().isNotEmpty
          ? membersVM.selectedState
          : '',
      membersVM.selectedCountry != 'Select Country' &&
              membersVM.selectedCountry.toString().isNotEmpty
          ? membersVM.selectedCountry
          : '',
      membersVM.memberNameController.text,
      membersVM.selectedBusinessCategory.toString().isNotEmpty &&
              membersVM.selectedBusinessCategory != membersVM.businessCatList[0]
          ? membersVM.selectedBusinessCategory.toString().toUpperCase()
          : '',
      membersVM.selectedChapter != 'Select Chapter' &&
              membersVM.selectedChapter.toString().isNotEmpty
          ? membersVM.selectedChapter
          : '',
    );
  }
}
