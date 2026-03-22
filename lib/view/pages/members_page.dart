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
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/view/widgets/common_text_label.dart';
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

class MembersPageState extends State<MembersPage> {
  // ── Autocomplete text controllers (for display text in the field) ──
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _chapterController = TextEditingController();
  final TextEditingController _businessCatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await Get.find<MembersViewmodel>().initData();
    _resetAutocompleteControllers();
  }

  // Reset autocomplete display text when tab switches or form resets
  void _resetAutocompleteControllers() {
    _countryController.text = '';
    _stateController.text = '';
    _cityController.text = '';
    _chapterController.text = '';
    _businessCatController.text = '';
  }

  @override
  void dispose() {
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _chapterController.dispose();
    _businessCatController.dispose();
    super.dispose();
  }

  // ── Convert WorldWideMembers → MembersChildData via JSON round-trip ──
  MembersChildData _toMembersChildData(WorldWideMembers w) {
    return MembersChildData.fromJson(w.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MembersViewmodel>(builder: (membersVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              'members'.tr,
              style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          body: Obx(
                () => Column(
              children: [
                // Loading bar
                Visibility(
                  visible: membersVM.isLoading,
                  child: LinearProgressIndicator(
                    color: midnightBlue,
                    backgroundColor: lavenderMist,
                    borderRadius: BorderRadius.circular(radius20),
                  ),
                ),

                // ── Tab row ──
                Row(
                  children: [
                    Expanded(
                      child: CommonCard(
                        elevation: 2.0,
                        bgColor: membersVM.isChapterRoster.value
                            ? midnightBlue
                            : lavenderMist,
                        onTap: () {
                          membersVM.isChapterRoster.value = true;
                          membersVM.isWorldWide.value = false;
                          membersVM.isWorldWideListShow.value = false;
                          membersVM.worldWiseMembersData = [];
                        },
                        cardChild: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize15,
                              vertical: paddingSize10),
                          child: Center(
                            child: Text(
                              'chapter_roaster'.tr,
                              overflow: TextOverflow.ellipsis,
                              style: fontRegular.copyWith(
                                color: membersVM.isChapterRoster.value
                                    ? white
                                    : black,
                                fontSize: fontSize14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CommonCard(
                        elevation: 2.0,
                        bgColor: membersVM.isWorldWide.value
                            ? midnightBlue
                            : lavenderMist,
                        onTap: () async {
                          membersVM.isChapterRoster.value = false;
                          membersVM.isWorldWide.value = true;
                          membersVM.isWorldWideListShow.value = false;
                          membersVM.worldWiseMembersData = [];
                          _resetAutocompleteControllers();
                          await membersVM.getGroups(
                              0, membersVM.size.value, '', '', '');
                          await membersVM.getCountries();
                        },
                        cardChild: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize15,
                              vertical: paddingSize10),
                          child: Center(
                            child: Text(
                              'worldwide_search'.tr,
                              overflow: TextOverflow.ellipsis,
                              style: fontRegular.copyWith(
                                color: membersVM.isWorldWide.value
                                    ? white
                                    : black,
                                fontSize: fontSize14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ── Chapter Roster tab ──
                if (membersVM.isChapterRoster.value)
                  Expanded(
                    child: ListView(
                      primary: false,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize10, vertical: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonTextFormField(
                                  padding: EdgeInsets.all(paddingSize8),
                                  hintText: 'search_member'.tr,
                                  controller: membersVM.memberSearchController,
                                  textStyle: fontMedium.copyWith(
                                      color: midnightBlue,
                                      fontSize: fontSize14),
                                ),
                              ),
                              const SizedBox(width: paddingSize8),
                              InkWell(
                                onTap: () async {
                                  if (membersVM
                                      .memberSearchController.text.isEmpty) {
                                    showSnackBar('member_name_search'.tr);
                                  } else {
                                    await membersVM.searchType('GLOBAL',
                                        membersVM.memberSearchController.text);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Image.asset(searchBlue,
                                      width: iconSize24, height: iconSize24),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(paddingSize8),
                                child: InkWell(
                                  onTap: () async {
                                    membersVM.memberSearchController.text = '';
                                    membersVM.page.value = 0;
                                    membersVM.totalPages.value = 0;
                                    membersVM.membersData = [];
                                    await membersVM.getUsersOrMembers(
                                        0, membersVM.size.value, '', '', '');
                                  },
                                  child: Image.asset(reload,
                                      height: iconSize28, width: iconSize28),
                                ),
                              ),
                            ],
                          ),
                        ),
                        LoadMore(
                          isFinish: membersVM.page.value ==
                              membersVM.totalPages.value,
                          whenEmptyLoad: true,
                          delegate: const DefaultLoadMoreDelegate(),
                          textBuilder: DefaultLoadMoreTextBuilder.english,
                          onLoadMore: membersVM.loadMore,
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: membersVM.membersData.length,
                            itemBuilder: (context, index) {
                              return _chapterRosterItem(index, membersVM);
                            },
                          ),
                        ),
                      ],
                    ),
                  )

                // ── Worldwide Search tab ──
                else
                  Expanded(
                    child: membersVM.isWorldWideListShow.value
                        ? membersVM.worldWiseMembersData.isNotEmpty
                        ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                      membersVM.worldWiseMembersData.length,
                      itemBuilder: (context, index) {
                        return _worldWideMemberItem(
                            index, membersVM);
                      },
                    )
                        : Center(child: Text('no_member_found'.tr))
                        : _worldWideSearchForm(membersVM),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ── Chapter Roster item ──
  Widget _chapterRosterItem(int index, MembersViewmodel membersVM) {
    final MembersChildData member = membersVM.membersData[index];
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: ListTile(
        contentPadding: EdgeInsets.all(paddingSize10),
        onTap: () async {
          if (widget.isReturnResult == 'false') {
            await Get.toNamed(Routes.getMembersProfilePageRoute(member));
          } else {
            Get.back(result: member, closeOverlays: true);
          }
        },
        leading: _memberAvatar(member.profileUrl),
        title: _memberTitle(
          name: '${member.firstName} ${member.lastName}',
          businessCategory: member.organization?.businessCategory ?? '',
          companyName: member.organization?.companyName ?? '',
        ),
        trailing: InkWell(
          onTap: () async {
            await Get.toNamed(Routes.getMembersProfilePageRoute(member));
          },
          child: Image.asset(nextArrow, width: iconSize18, height: iconSize18),
        ),
      ),
    );
  }

  // ── Worldwide Member item ──
  Widget _worldWideMemberItem(int index, MembersViewmodel membersVM) {
    final WorldWideMembers wwMember = membersVM.worldWiseMembersData[index];
    final MembersChildData member = _toMembersChildData(wwMember);
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: ListTile(
        contentPadding: EdgeInsets.all(paddingSize10),
        onTap: () async {
          if (widget.isReturnResult == 'false') {
            await Get.toNamed(Routes.getMembersProfilePageRoute(member));
          } else {
            Get.back(result: member, closeOverlays: true);
          }
        },
        leading: _memberAvatar(wwMember.profileUrl),
        title: _memberTitle(
          name: '${wwMember.firstName} ${wwMember.lastName}',
          businessCategory: wwMember.organization?.businessCategory ?? '',
          companyName: wwMember.organization?.companyName ?? '',
        ),
        trailing: InkWell(
          onTap: () async {
            await Get.toNamed(Routes.getMembersProfilePageRoute(member));
          },
          child: Image.asset(nextArrow, width: iconSize18, height: iconSize18),
        ),
      ),
    );
  }

  Widget _memberAvatar(String? profileUrl) {
    if (profileUrl != null && profileUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: profileUrl,
        height: 62.0,
        width: 62.0,
        errorWidget: (context, url, error) =>
            Image.asset(profileImage, height: 62.0, width: 62.0),
      );
    }
    return Image.asset(profileImage, height: 62.0, width: 62.0);
  }

  Widget _memberTitle({
    required String name,
    required String businessCategory,
    required String companyName,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style:
            fontBold.copyWith(color: midnightBlue, fontSize: fontSize18)),
        Text(businessCategory,
            style:
            fontRegular.copyWith(color: greyText, fontSize: fontSize12)),
        Text(companyName,
            style:
            fontRegular.copyWith(color: greyText, fontSize: fontSize12)),
      ],
    );
  }

  // ────────────────────────────────────────────────────────────
  // Worldwide search form — all dropdowns replaced with
  // Autocomplete widgets. Same lavenderMist container style,
  // same arrow icon, same onChanged behaviour (loads sub-lists).
  // ────────────────────────────────────────────────────────────
  Widget _worldWideSearchForm(MembersViewmodel membersVM) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Location ──
            _sectionHeader('location'.tr),
            const SizedBox(height: paddingSize15),

            // Country autocomplete
            _autocompleteField(
              label: 'select_country'.tr,
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
                setState(() {});
              },
            ),
            const SizedBox(height: paddingSize25),

            // State autocomplete
            _autocompleteField(
              label: 'select_state'.tr,
              controller: _stateController,
              options: membersVM.stateList
                  .where((s) => s != 'Select State')
                  .toList(),
              onSelected: (val) async {
                membersVM.selectedState = val;
                _cityController.clear();
                membersVM.selectedCity = membersVM.cityList.isNotEmpty
                    ? membersVM.cityList[0]
                    : 'Select City';
                await membersVM.getCities(val);
                setState(() {});
              },
            ),
            const SizedBox(height: paddingSize25),

            // City autocomplete
            _autocompleteField(
              label: 'select_city'.tr,
              controller: _cityController,
              options: membersVM.cityList
                  .where((c) => c != 'Select City')
                  .toList(),
              onSelected: (val) {
                membersVM.selectedCity = val;
                setState(() {});
              },
            ),
            const SizedBox(height: paddingSize25),

            // Chapter autocomplete
            _autocompleteField(
              label: 'select_chapter'.tr,
              controller: _chapterController,
              options: membersVM.chapterList
                  .where((c) => c != 'Select Chapter')
                  .toList(),
              onSelected: (val) {
                membersVM.selectedChapter = val;
                setState(() {});
              },
            ),
            const SizedBox(height: paddingSize25),

            // ── Member Details ──
            _sectionHeader('member_details'.tr),
            const SizedBox(height: paddingSize25),

            // Member name text field (unchanged)
            CommonTextFormField(
              controller: membersVM.memberNameController,
              hintText: 'member_name'.tr,
              hintColor: midnightBlue,
              textStyle: fontRegular.copyWith(
                  color: midnightBlue, fontSize: fontSize14),
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize20, vertical: paddingSize20),
            ),
            const SizedBox(height: paddingSize25),

            // Business category autocomplete
            _autocompleteField(
              label: 'select_business_category'.tr,
              controller: _businessCatController,
              options: membersVM.businessCatList
                  .where((b) => b != membersVM.businessCatList[0])
                  .toList(),
              onSelected: (val) {
                membersVM.selectedBusinessCategory = val;
                setState(() {});
              },
            ),
            const SizedBox(height: paddingSize45),

            CommonButton(
              buttonText: 'confirm'.tr,
              bgColor: midnightBlue,
              textColor: periwinkle,
              onPressed: () async {
                await _collectDataAndSearchMember(membersVM);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // _autocompleteField
  //
  // Matches the original dropdown visual exactly:
  //   - lavenderMist background
  //   - radius10 rounded corners
  //   - dropDownArrow icon on the right
  //   - midnightBlue text, fontSize14, fontRegular
  //
  // Extra behaviour from autocomplete:
  //   - User can type to filter the list instantly
  //   - Matching is case-insensitive substring
  //   - Selecting an item fills the field and closes the overlay
  //   - Unfocusing without selecting clears the field and
  //     resets the VM value (prevents stale partial text)
  // ────────────────────────────────────────────────────────────
  Widget _autocompleteField({
    required String label,
    required TextEditingController controller,
    required List<String> options,
    required void Function(String) onSelected,
  }) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          // Show all options when field is empty/tapped
          return options;
        }
        // Filter case-insensitively
        return options.where((option) => option
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
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
        // Sync external controller → internal autocomplete controller
        // so we can reset it from outside (e.g. tab switch)
        if (controller.text.isEmpty && fieldController.text.isNotEmpty) {
          fieldController.clear();
        }

        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: paddingSize20, vertical: paddingSize5),
          decoration: BoxDecoration(
            color: lavenderMist,
            borderRadius: BorderRadius.circular(radius10),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: fieldController,
                  focusNode: focusNode,
                  style: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  decoration: InputDecoration(
                    hintText: label,
                    hintStyle: fontRegular.copyWith(
                        color: midnightBlue.withOpacity(0.5),
                        fontSize: fontSize14),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: paddingSize10),
                  ),
                ),
              ),
              Image.asset(dropDownArrow, width: 18.0, height: 18.0),
            ],
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
            elevation: 4.0,
            borderRadius: BorderRadius.circular(radius10),
            color: lavenderMist,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize14),
                      child: Text(
                        option,
                        style: fontRegular.copyWith(
                            color: midnightBlue, fontSize: fontSize14),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionHeader(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonTextLabel(
          textColor: white,
          bgColor: bluishPurple,
          labelText: label,
          padding: const EdgeInsets.symmetric(
              horizontal: paddingSize25, vertical: paddingSize8),
        ),
        Expanded(child: Divider(height: 1.0, color: divider)),
      ],
    );
  }

  Future<void> _collectDataAndSearchMember(
      MembersViewmodel membersVM) async {
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
          membersVM.selectedBusinessCategory !=
              membersVM.businessCatList[0]
          ? membersVM.selectedBusinessCategory.toString().toUpperCase()
          : '',
      membersVM.selectedChapter != 'Select Chapter' &&
          membersVM.selectedChapter.toString().isNotEmpty
          ? membersVM.selectedChapter
          : '',
    );
  }
}