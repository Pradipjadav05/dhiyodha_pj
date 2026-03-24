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
  TyfcbPageState createState() => TyfcbPageState();
}

class TyfcbPageState extends State<TyfcbPage> {
  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<TyfcbViewModel>(builder: (tyVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "TYFCBs".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              tooltip: "Add TYFCBs",
              elevation: 4.0,
              backgroundColor: midnightBlue,
              onPressed: () async {
                await Get.toNamed(Routes.getAddTyPageRoute());
                await getTyfcbData(0, 10, "", "", "");
              },
              child: Icon(
                Icons.add,
                color: periwinkle,
                size: 32.0,
              )),
          body: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _tyfcbListItems(index, tyVM);
            },
            itemCount: tyVM.tyfcbList.length,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _tyfcbListItems(int index, TyfcbViewModel tyVM) {
    TyfcbChildData tyfcbData = tyVM.tyfcbList[index];
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: Obx(
        () => ExpansionTile(
          dense: false,
          leading: Image.asset(
            profileImage,
            width: 48.0,
            height: 48.0,
          ),
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(meeting,
                              color: bluishPurple,
                              height: iconSize18,
                              width: iconSize18),
                          SizedBox(width: paddingSize5),
                          Text(
                            "Status",
                            style: fontRegular.copyWith(
                                fontSize: fontSize12, color: midnightBlue),
                          ),
                        ],
                      ),
                      Text(
                        tyfcbData.meetingDetails?.status ?? "",
                        style: fontMedium.copyWith(
                            fontSize: fontSize14, color: midnightBlue),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(company,
                              height: iconSize18, width: iconSize18),
                          SizedBox(width: paddingSize5),
                          Text(
                            "Business Type",
                            style: fontRegular.copyWith(
                                fontSize: fontSize12, color: midnightBlue),
                          ),
                        ],
                      ),
                      Text(
                        tyfcbData.businessType ?? "",
                        style: fontMedium.copyWith(
                            fontSize: fontSize14, color: midnightBlue),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(referralsBlue,
                              height: iconSize18, width: iconSize18),
                          SizedBox(width: paddingSize5),
                          Text(
                            "Referral Type",
                            style: fontRegular.copyWith(
                                fontSize: fontSize12, color: midnightBlue),
                          ),
                        ],
                      ),
                      Text(
                        tyfcbData.referralType ?? "",
                        style: fontMedium.copyWith(
                            fontSize: fontSize14, color: midnightBlue),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.2,
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(postComment,
                                color: bluishPurple,
                                height: iconSize18,
                                width: iconSize18),
                            SizedBox(width: paddingSize5),
                            Text(
                              "Comments",
                              style: fontRegular.copyWith(
                                  fontSize: fontSize12, color: midnightBlue),
                            ),
                          ],
                        ),
                        Text(
                          tyfcbData.comments ?? "",
                          style: fontMedium.copyWith(
                              fontSize: fontSize14, color: midnightBlue),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.2,
                ),
              ],
            ),
          ],
          subtitle: Text(
            "GiftAmount : ${tyfcbData.giftAmount ?? "0.0"}",
            style: fontRegular.copyWith(fontSize: fontSize12, color: greyText),
          ),
          shape: Border(),
          title: Text(
            "${tyfcbData.recipient?.firstName ?? ""} ${tyfcbData.recipient?.lastName ?? ""}",
            style: fontBold.copyWith(fontSize: fontSize16, color: midnightBlue),
          ),
          onExpansionChanged: (isExpandedItem) {
            tyVM.isExpanded.value = isExpandedItem;
          },
          trailing: tyVM.isExpanded.value
              ? Image.asset(
                  nextArrow,
                  height: iconSize18,
                  width: iconSize18,
                )
              : Image.asset(
                  dropDownArrow,
                  height: iconSize18,
                  width: iconSize18,
                ),
        ),
      ),
    );
  }
}
