import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
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
  String isReturnResult = "false";

  MembersPageState createState() => MembersPageState();

  MembersPage({required this.isReturnResult});
}

class MembersPageState extends State<MembersPage> {
  LoadMoreStatus status = LoadMoreStatus.outScreen;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await Get.find<MembersViewmodel>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MembersViewmodel>(builder: (membersVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "members".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
          body: Obx(
            () => Column(
              children: [
                Visibility(
                  visible: membersVM.isLoading,
                  child: LinearProgressIndicator(
                    color: midnightBlue,
                    backgroundColor: lavenderMist,
                    borderRadius: BorderRadius.circular(radius20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        },
                        cardChild: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize15,
                              vertical: paddingSize10),
                          child: Center(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "chapter_roaster".tr,
                              style: fontRegular.copyWith(
                                  color: membersVM.isChapterRoster.value
                                      ? white
                                      : black,
                                  fontSize: fontSize14),
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
                          await membersVM.getGroups(
                              0, membersVM.size.value, "", "", "");
                          await membersVM.getCountries();
                        },
                        cardChild: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize15,
                              vertical: paddingSize10),
                          child: Center(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "worldwide_search".tr,
                              style: fontRegular.copyWith(
                                  color: membersVM.isWorldWide.value
                                      ? white
                                      : black,
                                  fontSize: fontSize14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                membersVM.isChapterRoster.value == true
                    ? Expanded(
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
                                    hintText: "search_member".tr,
                                    controller:
                                        membersVM.memberSearchController,
                                    textStyle: fontMedium.copyWith(
                                        color: midnightBlue,
                                        fontSize: fontSize14),
                                  ),
                                ),
                                SizedBox(width: paddingSize8),
                                InkWell(
                                  onTap: () async {
                                    if (membersVM
                                        .memberSearchController.text.isEmpty) {
                                      showSnackBar("member_name_search".tr);
                                    } else {
                                      await membersVM.searchType(
                                          "GLOBAL",
                                          membersVM
                                              .memberSearchController.text);
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
                                      membersVM.memberSearchController.text =
                                          "";
                                      membersVM.page.value = 0;
                                      membersVM.totalPages.value = 0;
                                      membersVM.membersData = [];
                                      await membersVM.getUsersOrMembers(
                                          membersVM.page.value,
                                          membersVM.size.value,
                                          "",
                                          "",
                                          "");
                                    },
                                    child: Image.asset(
                                      reload,
                                      height: iconSize28,
                                      width: iconSize28,
                                    ),
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
                              child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  return _membersListItems(index, membersVM);
                                },
                                itemCount: membersVM.membersData.length,
                              ),
                              onLoadMore: membersVM.loadMore),
                        ],
                      ))
                    : Expanded(
                        child: membersVM.isWorldWideListShow.value
                            ? membersVM.worldWiseMembersData.isNotEmpty
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return _worldWideMembersListItems(
                                          index, membersVM);
                                    },
                                    itemCount:
                                        membersVM.worldWiseMembersData.length,
                                  )
                                : Text("no_member_found".tr)
                            : worldWideSearch(membersVM),
                      )
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

  Widget worldWideSearch(MembersViewmodel membersVM) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextLabel(
                    textColor: white,
                    bgColor: bluishPurple,
                    labelText: "location".tr,
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize25, vertical: paddingSize8)),
                Expanded(
                  child: Divider(
                    height: 1.0,
                    color: divider,
                  ),
                )
              ],
            ),
            SizedBox(height: paddingSize15),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize20, vertical: paddingSize5),
              decoration: BoxDecoration(
                color: lavenderMist,
                borderRadius: BorderRadius.circular(radius10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: const Offset(0, 0))
                ],
              ),
              child: DropdownButton(
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  underline: const SizedBox(),
                  style: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  value: membersVM.selectedCountry,
                  isExpanded: true,
                  items: membersVM.countryList.map((String val) {
                    return DropdownMenuItem(
                        child: Text(
                          val,
                          style: fontRegular.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        ),
                        value: val);
                  }).toList(),
                  onChanged: (val) async {
                    membersVM.selectedCountry = val ?? "";
                    if (membersVM.selectedCountry != membersVM.countryList[0]) {
                      await membersVM.getStates(membersVM.selectedCountry);
                    }
                    setState(() {});
                  }),
            ),
            SizedBox(height: paddingSize25),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize20, vertical: paddingSize5),
              decoration: BoxDecoration(
                color: lavenderMist,
                borderRadius: BorderRadius.circular(radius10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: const Offset(0, 0))
                ],
              ),
              child: DropdownButton(
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  underline: const SizedBox(),
                  style: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  value: membersVM.selectedState,
                  isExpanded: true,
                  items: membersVM.stateList.map((String val) {
                    return DropdownMenuItem(
                        child: Text(
                          val,
                          style: fontRegular.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        ),
                        value: val);
                  }).toList(),
                  onChanged: (val) async {
                    membersVM.selectedState = val ?? "";
                    if (membersVM.selectedState != membersVM.stateList[0]) {
                      await membersVM.getCities(membersVM.selectedState);
                    }
                    setState(() {});
                  }),
            ),
            SizedBox(height: paddingSize25),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize20, vertical: paddingSize5),
              decoration: BoxDecoration(
                color: lavenderMist,
                borderRadius: BorderRadius.circular(radius10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: const Offset(0, 0))
                ],
              ),
              child: DropdownButton(
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  underline: const SizedBox(),
                  style: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  value: membersVM.selectedCity,
                  isExpanded: true,
                  items: membersVM.cityList.map((String val) {
                    return DropdownMenuItem(
                        child: Text(
                          val,
                          style: fontRegular.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        ),
                        value: val);
                  }).toList(),
                  onChanged: (val) {
                    membersVM.selectedCity = val ?? "";
                    setState(() {});
                  }),
            ),
            SizedBox(height: paddingSize25),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize20, vertical: paddingSize5),
              decoration: BoxDecoration(
                color: lavenderMist,
                borderRadius: BorderRadius.circular(radius10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: const Offset(0, 0))
                ],
              ),
              child: DropdownButton(
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  underline: const SizedBox(),
                  style: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  value: membersVM.selectedChapter,
                  isExpanded: true,
                  items: membersVM.chapterList.map((String group) {
                    return DropdownMenuItem(
                      child: Text(
                        group,
                        style: fontRegular.copyWith(
                            color: midnightBlue, fontSize: fontSize14),
                      ),
                      value: group,
                    );
                  }).toList(),
                  onChanged: (val) {
                    membersVM.selectedChapter = val ?? "";
                    setState(() {});
                  }),
            ),
            SizedBox(height: paddingSize25),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextLabel(
                    textColor: white,
                    bgColor: bluishPurple,
                    labelText: "member_details".tr,
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize25, vertical: paddingSize8)),
                Expanded(
                  child: Divider(
                    height: 1.0,
                    color: divider,
                  ),
                )
              ],
            ),
            SizedBox(height: paddingSize25),
            CommonTextFormField(
              controller: membersVM.memberNameController,
              hintText: "member_name".tr,
              hintColor: midnightBlue,
              textStyle: fontRegular.copyWith(
                  color: midnightBlue, fontSize: fontSize14),
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize20, vertical: paddingSize20),
            ),
            SizedBox(height: paddingSize25),
            // CommonTextFormField(
            //   controller: membersVM.companyNameController,
            //   hintText: "Company Name".tr,
            //   hintColor: midnightBlue,
            //   textStyle:
            //       fontRegular.copyWith(color: midnightBlue, fontSize: fontSize14),
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: paddingSize20, vertical: paddingSize20),
            // ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize20, vertical: paddingSize5),
              decoration: BoxDecoration(
                color: lavenderMist,
                borderRadius: BorderRadius.circular(radius10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: const Offset(0, 0))
                ],
              ),
              child: DropdownButton(
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  underline: const SizedBox(),
                  style: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  value: membersVM.selectedBusinessCategory,
                  isExpanded: true,
                  items: membersVM.businessCatList.map((String val) {
                    return DropdownMenuItem(
                        child: Text(
                          val,
                          style: fontRegular.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        ),
                        value: val);
                  }).toList(),
                  onChanged: (val) async {
                    membersVM.selectedBusinessCategory = val ?? "";
                    if (membersVM.selectedBusinessCategory !=
                        membersVM.businessCatList[0]) {}
                    setState(() {});
                  }),
            ),
            SizedBox(height: paddingSize45),
            CommonButton(
              buttonText: "confirm".tr,
              bgColor: midnightBlue,
              textColor: periwinkle,
              onPressed: () async {
                await _collectDataAndSearchMember(membersVM);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _collectDataAndSearchMember(MembersViewmodel membersVM) async {
    await membersVM.getWorldWideSearchedUsersOrMembers(
      membersVM.selectedCity != membersVM.cityList[0]
          ? membersVM.selectedCity
          : "",
      membersVM.selectedState != membersVM.stateList[0]
          ? membersVM.selectedState
          : "",
      membersVM.selectedCountry != membersVM.countryList[0]
          ? membersVM.selectedCountry
          : "",
      membersVM.memberNameController.text,
      membersVM.selectedBusinessCategory != membersVM.businessCatList[0]
          ? membersVM.selectedBusinessCategory.toString().toUpperCase()
          : "",
      membersVM.selectedChapter != membersVM.chapterList[0]
          ? membersVM.selectedChapter
          : "",
    );
  }

  _membersListItems(int index, MembersViewmodel membersVM) {
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: ListTile(
        contentPadding: EdgeInsets.all(paddingSize10),
        onTap: () async {
          if (widget.isReturnResult == "false") {
            await Get.toNamed(Routes.getMembersProfilePageRoute(
                membersVM.membersData[index]));
          } else {
            Get.back(result: membersVM.membersData[index], closeOverlays: true);
          }
        },
        leading: membersVM.membersData[index].profileUrl != null &&
                membersVM.membersData[index].profileUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: membersVM.membersData[index].profileUrl!,
                height: 62.0,
                width: 62.0,
                errorWidget: (context, url, error) => Image.asset(
                  profileImage,
                  height: 62.0,
                  width: 62.0,
                ),
              )
            : Image.asset(
                profileImage,
                height: 62.0,
                width: 62.0,
              ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${membersVM.membersData[index].firstName} ${membersVM.membersData[index].lastName}',
              style:
                  fontBold.copyWith(color: midnightBlue, fontSize: fontSize18),
            ),
            Text(
              '${membersVM.membersData[index].organization?.businessCategory ?? ""}',
              style:
                  fontRegular.copyWith(color: greyText, fontSize: fontSize12),
            ),
            Text(
              '${membersVM.membersData[index].organization?.companyName ?? ""}',
              style:
                  fontRegular.copyWith(color: greyText, fontSize: fontSize12),
            ),
          ],
        ),
        trailing: InkWell(
          onTap: () async {
            await Get.toNamed(Routes.getMembersProfilePageRoute(
                membersVM.membersData[index]));
          },
          child: Image.asset(
            nextArrow,
            width: iconSize18,
            height: iconSize18,
          ),
        ),
      ),
    );
  }

  _worldWideMembersListItems(int index, MembersViewmodel membersVM) {
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: ListTile(
        contentPadding: EdgeInsets.all(paddingSize10),
        onTap: () async {
          if (widget.isReturnResult == "false") {
            await Get.toNamed(Routes.getMembersProfilePageRoute(
                membersVM.membersData[index]));
          } else {
            Get.back(result: membersVM.membersData[index], closeOverlays: true);
          }
        },
        leading: membersVM.worldWiseMembersData[index].profileUrl != null &&
                membersVM.worldWiseMembersData[index].profileUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: membersVM.worldWiseMembersData[index].profileUrl ??
                    profileImage,
                height: 62.0,
                width: 62.0,
                errorWidget: (context, url, error) => Image.asset(
                  profileImage,
                  height: 62.0,
                  width: 62.0,
                ),
              )
            : Image.asset(profileImage, height: 62.0, width: 62.0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${membersVM.worldWiseMembersData[index].firstName} ${membersVM.worldWiseMembersData[index].lastName}',
              style:
                  fontBold.copyWith(color: midnightBlue, fontSize: fontSize18),
            ),
            Text(
              '${membersVM.worldWiseMembersData[index].organization?.businessCategory ?? ""}',
              style:
                  fontRegular.copyWith(color: greyText, fontSize: fontSize12),
            ),
            Text(
              '${membersVM.worldWiseMembersData[index].organization?.companyName ?? ""}',
              style:
                  fontRegular.copyWith(color: greyText, fontSize: fontSize12),
            ),
          ],
        ),
        trailing: InkWell(
          onTap: () async {
            // await Get.toNamed(Routes.getMembersProfilePageRoute(
            //     membersVM.worldWiseMembersData[index]));
          },
          child: Image.asset(
            nextArrow,
            width: iconSize18,
            height: iconSize18,
          ),
        ),
      ),
    );
  }
}
