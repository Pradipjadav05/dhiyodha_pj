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
  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await Get.find<MembersViewmodel>().initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ────────────────────────────────────────────────────────────
  // Convert WorldWideMembers → MembersChildData via JSON
  //
  // WorldWideMembers.toJson() produces:
  //   { firstName, lastName, uuid, profileUrl, mobileNo,
  //     businessDetails: { companyName, businessCategory,
  //                        officeNumber, officeEmail },
  //     address: { city, state, country, pinCode } }
  //
  // MembersChildData.fromJson() reads 'businessDetails' key for
  // organization — so the JSON round-trip works perfectly without
  // any manual field mapping. No type mismatch, no missing fields.
  // ────────────────────────────────────────────────────────────
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
                // ── Loading bar ──
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
                                  controller:
                                  membersVM.memberSearchController,
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

    // Convert once — used for both onTap and trailing tap
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

  // ── Shared avatar ──
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

  // ── Shared title ──
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

  // ── Worldwide search form ──
  Widget _worldWideSearchForm(MembersViewmodel membersVM) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('location'.tr),
            const SizedBox(height: paddingSize15),
            _dropdownField(
              value: membersVM.selectedCountry,
              items: membersVM.countryList,
              onChanged: (val) async {
                membersVM.selectedCountry = val ?? '';
                if (membersVM.selectedCountry != membersVM.countryList[0]) {
                  await membersVM.getStates(membersVM.selectedCountry);
                }
                setState(() {});
              },
            ),
            const SizedBox(height: paddingSize25),
            _dropdownField(
              value: membersVM.selectedState,
              items: membersVM.stateList,
              onChanged: (val) async {
                membersVM.selectedState = val ?? '';
                if (membersVM.selectedState != membersVM.stateList[0]) {
                  await membersVM.getCities(membersVM.selectedState);
                }
                setState(() {});
              },
            ),
            const SizedBox(height: paddingSize25),
            _dropdownField(
              value: membersVM.selectedCity,
              items: membersVM.cityList,
              onChanged: (val) {
                membersVM.selectedCity = val ?? '';
                setState(() {});
              },
            ),
            const SizedBox(height: paddingSize25),
            _dropdownField(
              value: membersVM.selectedChapter,
              items: membersVM.chapterList,
              onChanged: (val) {
                membersVM.selectedChapter = val ?? '';
                setState(() {});
              },
            ),
            const SizedBox(height: paddingSize25),
            _sectionHeader('member_details'.tr),
            const SizedBox(height: paddingSize25),
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
            _dropdownField(
              value: membersVM.selectedBusinessCategory,
              items: membersVM.businessCatList,
              onChanged: (val) {
                membersVM.selectedBusinessCategory = val ?? '';
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

  Widget _dropdownField({
    required dynamic value,
    required List<String> items,
    required void Function(dynamic) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: paddingSize20, vertical: paddingSize5),
      decoration: BoxDecoration(
        color: lavenderMist,
        borderRadius: BorderRadius.circular(radius10),
      ),
      child: DropdownButton<String>(
        icon: Image.asset(dropDownArrow, width: 18.0, height: 18.0),
        underline: const SizedBox(),
        style:
        fontRegular.copyWith(color: midnightBlue, fontSize: fontSize14),
        value: value,
        isExpanded: true,
        items: items.map((String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val,
                style: fontRegular.copyWith(
                    color: midnightBlue, fontSize: fontSize14)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Future<void> _collectDataAndSearchMember(
      MembersViewmodel membersVM) async {
    await membersVM.getWorldWideSearchedUsersOrMembers(
      membersVM.selectedCity != membersVM.cityList[0]
          ? membersVM.selectedCity
          : '',
      membersVM.selectedState != membersVM.stateList[0]
          ? membersVM.selectedState
          : '',
      membersVM.selectedCountry != membersVM.countryList[0]
          ? membersVM.selectedCountry
          : '',
      membersVM.memberNameController.text,
      membersVM.selectedBusinessCategory != membersVM.businessCatList[0]
          ? membersVM.selectedBusinessCategory.toString().toUpperCase()
          : '',
      membersVM.selectedChapter != membersVM.chapterList[0]
          ? membersVM.selectedChapter
          : '',
    );
  }
}