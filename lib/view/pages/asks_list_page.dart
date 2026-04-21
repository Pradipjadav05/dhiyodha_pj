import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhiyodha/model/response_model/ask_list_response_model.dart';
import 'package:dhiyodha/model/response_model/response_model.dart';
import 'package:dhiyodha/utils/helper/date_converter.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/viewModel/asks_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

class AsksListPage extends StatefulWidget {
  AsksListPageState createState() => AsksListPageState();
}

class AsksListPageState extends State<AsksListPage> {
  @override
  void initState() {
    super.initState();
    callInitAPIs();
  }

  Future<void> callInitAPIs() async {
    AsksViewModel asksViewModel = Get.find<AsksViewModel>();
    await asksViewModel.initData();
    await asksViewModel.getAsksList(
        asksViewModel.page.value, asksViewModel.size.value, "", "", "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<AsksViewModel>(builder: (askVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: AppBar(
            title: Image.asset(
              appLogoLong,
              width: 100.0,
            ),
            actions: [
              InkWell(
                onTap: () async {
                  await Get.toNamed(Routes.getMembersPageRoute("false"));
                },
                child: Image.asset(
                  search,
                  height: iconSize20,
                  width: iconSize20,
                ),
              ),
              SizedBox(width: paddingSize20),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.getNotificationPageRoute());
                },
                child: Image.asset(
                  notificationIcon,
                  height: iconSize20,
                  width: iconSize20,
                ),
              ),
              SizedBox(width: paddingSize20),
              InkWell(
                onTap: () async {
                  await showFilterDialog(askVM);
                },
                child: Image.asset(
                  filter,
                  color: black,
                  height: iconSize20,
                  width: iconSize20,
                ),
              ),
              SizedBox(width: paddingSize20),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: askVM.isLoading,
                child: LinearProgressIndicator(
                  color: midnightBlue,
                  backgroundColor: lavenderMist,
                  borderRadius: BorderRadius.circular(radius20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: paddingSize10, vertical: paddingSize10),
                child: CommonCard(
                  elevation: 0.0,
                  bgColor: lavenderMist,
                  cardChild: InkWell(
                    onTap: () async {
                      ResponseModel resp = await Get.toNamed(
                        Routes.getAddAskPageRoute(),
                      );
                      if (resp.isSuccess) {
                        showSnackBar(resp.message, isError: false);
                        askVM.asksList = [];
                        askVM.page.value = 0;
                        askVM.totalPages.value = 0;
                        await askVM.getAsksList(
                            Get.find<AsksViewModel>().page.value,
                            Get.find<AsksViewModel>().size.value,
                            "",
                            "",
                            "");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize10, vertical: paddingSize15),
                      child: Row(
                        children: [
                          Text(
                            "post_text".tr,
                            style: fontMedium.copyWith(
                                color: midnightBlue, fontSize: fontSize14),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.asset(ask,
                                width: iconSize24, height: iconSize24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: paddingSize10, vertical: paddingSize10),
                child: Text(
                  askVM.selectedFilter.value == "My"
                      ? "my_asks".tr
                      : "all_ask".tr,
                  style: fontBold.copyWith(
                      color: midnightBlue, fontSize: fontSize16),
                ),
              ),
              askVM.asksList.isNotEmpty
                  ? Expanded(
                      child: LoadMore(
                          isFinish: askVM.page.value == askVM.totalPages.value,
                          whenEmptyLoad: true,
                          delegate: const DefaultLoadMoreDelegate(),
                          textBuilder: DefaultLoadMoreTextBuilder.english,
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _asksListItems(index, askVM);
                            },
                            itemCount: askVM.asksList.length,
                          ),
                          onLoadMore: askVM.loadMore),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          "no_asks".tr,
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize18),
                        ),
                      ),
                    )
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _asksListItems(int index, AsksViewModel askVM) {
    AskListChild item = askVM.asksList[index];
    String buttonTitle = "";
    switch (item.askType ?? "SPECIFIC") {
      case "SPECIFIC":
        buttonTitle = askVM.selectedFilter.value == "My"
            ? "view_connection".tr
            : "connect".tr;
        break;
      case "GENERAL":
        buttonTitle = askVM.selectedFilter.value == "My"
            ? "view_references".tr
            : "reference".tr;
        break;
      case "PERSONAL":
        buttonTitle =
            askVM.selectedFilter.value == "My" ? "view_help".tr : "help".tr;
        break;
      default:
        buttonTitle = askVM.selectedFilter.value == "My"
            ? "view_connection".tr
            : "connect".tr;
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: CommonCard(
        bgColor: white,
        elevation: 3.0,
        cardChild: Padding(
          padding: const EdgeInsets.all(paddingSize15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileAvatar(item.profileUrl ?? ""),
                  SizedBox(width: paddingSize10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item.firstName} ${item.lastName}',
                              style: fontMedium.copyWith(
                                  fontSize: fontSize14, color: midnightBlue),
                            ),
                            Text(
                              '${item.city},${item.state}',
                              style: fontMedium.copyWith(
                                  fontSize: fontSize10, color: greyText),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: paddingSize8),
                              child: Text(
                                '${DateConverter.convertDateToDate(item.createdAt ?? DateTime.now().toString())}',
                                style: fontRegular.copyWith(
                                    color: midnightBlue, fontSize: fontSize10),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        CommonCard(
                          bgColor: lavenderMist,
                          elevation: 2.0,
                          cardChild: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingSize10,
                                vertical: paddingSize5),
                            child: Text(
                              item.askType ?? "",
                              style: fontMedium.copyWith(
                                  fontSize: fontSize10, color: bluishPurple),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: paddingSize8),
                child: Text(
                  item.content ?? "",
                  style: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize10),
                ),
              ),
              SizedBox(height: paddingSize20),
              CommonButton(
                buttonText: buttonTitle.tr,
                bgColor: midnightBlue,
                textColor: periwinkle,
                onPressed: () async {
                  if (askVM.selectedFilter.value == "My") {
                    await Get.toNamed(
                      Routes.getAsksAnswerListPageRoute(item),
                    );
                  } else {
                    await Get.toNamed(
                      Routes.getConnectAskPageRoute(item),
                    );
                  }
                  askVM.asksList = [];
                  askVM.page.value = 0;
                  askVM.totalPages.value = 0;
                  await askVM.getAsksList(
                      askVM.page.value, askVM.size.value, "", "", "");
                  if (askVM.selectedFilter.value == "My") {
                    if (askVM.asksList.isNotEmpty) {
                      askVM.asksList
                          .where((e) =>
                              e.createdBy.toString() ==
                              globalCurrentUserData.uuid)
                          .toList();
                      setState(() {});
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileAvatar(String? profileUrl) {
    return Container(
      width: 42,
      height: 42,
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
          width: 42,
          height: 42,
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

  Future<void> showFilterDialog(AsksViewModel askVM) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: paddingSize25),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: paddingSize10, horizontal: paddingSize20),
                  child: InkWell(
                    onTap: () async {
                      Get.back();
                      if (askVM.selectedFilter.isNotEmpty &&
                          askVM.selectedFilter.value == "My") {
                        askVM.selectedFilter.value = "";
                        askVM.asksList = [];
                        askVM.page.value = 0;
                        askVM.totalPages.value = 0;
                        await askVM.getAsksList(
                            askVM.page.value, askVM.size.value, "", "", "");
                      }
                    },
                    child: Row(
                      children: [
                        Image.asset(ask,
                            color: bluishPurple,
                            height: iconSize24,
                            width: iconSize24),
                        SizedBox(width: paddingSize10),
                        Text(
                          "all_ask".tr,
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: paddingSize10, horizontal: paddingSize20),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      askVM.selectedFilter.value = "My";
                      if (askVM.asksList.isNotEmpty) {
                        askVM.asksList
                            .where((e) =>
                                e.createdBy.toString() ==
                                globalCurrentUserData.uuid)
                            .toList();
                        setState(() {});
                      }
                    },
                    child: Row(
                      children: [
                        Image.asset(ask,
                            color: bluishPurple,
                            height: iconSize24,
                            width: iconSize24),
                        SizedBox(width: paddingSize10),
                        Text(
                          "my_asks".tr,
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                  ),
                ),
                // Divider(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       vertical: paddingSize10, horizontal: paddingSize20),
                //   child: InkWell(
                //     onTap: () {
                //       Get.back();
                //       askVM.setSelectedFilter("Specific");
                //       setState(() {});
                //     },
                //     child: Row(
                //       children: [
                //         Image.asset(ask,
                //             color: bluishPurple,
                //             height: iconSize24,
                //             width: iconSize24),
                //         SizedBox(width: paddingSize10),
                //         Text(
                //           "Specific Asks",
                //           style: fontMedium.copyWith(
                //               color: midnightBlue, fontSize: fontSize14),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Divider(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       vertical: paddingSize10, horizontal: paddingSize20),
                //   child: InkWell(
                //     onTap: () {
                //       Get.back();
                //       askVM.setSelectedFilter("Personal");
                //       setState(() {});
                //     },
                //     child: Row(
                //       children: [
                //         Image.asset(ask,
                //             color: bluishPurple,
                //             height: iconSize24,
                //             width: iconSize24),
                //         SizedBox(width: paddingSize10),
                //         Text(
                //           "Personal Asks",
                //           style: fontMedium.copyWith(
                //               color: midnightBlue, fontSize: fontSize14),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Divider(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       vertical: paddingSize10, horizontal: paddingSize20),
                //   child: InkWell(
                //     onTap: () {
                //       Get.back();
                //       askVM.setSelectedFilter("General");
                //       setState(() {});
                //     },
                //     child: Row(
                //       children: [
                //         Image.asset(ask,
                //             color: bluishPurple,
                //             height: iconSize24,
                //             width: iconSize24),
                //         SizedBox(width: paddingSize10),
                //         Text(
                //           "General Asks",
                //           style: fontMedium.copyWith(
                //               color: midnightBlue, fontSize: fontSize14),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: paddingSize25),
              ],
            ),
          ),
        );
      },
    );
  }
}
