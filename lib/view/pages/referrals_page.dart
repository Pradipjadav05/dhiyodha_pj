import 'package:dhiyodha/model/response_model/referral_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/viewModel/referral_slip_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReferralsPage extends StatefulWidget {
  ReferralsPageState createState() => ReferralsPageState();
}

class ReferralsPageState extends State<ReferralsPage> {
  @override
  void initState() {
    super.initState();
    getReferralData(0, 10, "", "", "");
  }

  Future<void> getReferralData(
      int page, int size, String? sort, String? orderBy, String? search) async {
    await Get.find<ReferralSlipViewModel>()
        .getReferralData(page, size, sort, orderBy, search);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ReferralSlipViewModel>(builder: (rVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "Referrals".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              tooltip: "Add Referrals",
              elevation: 4.0,
              backgroundColor: midnightBlue,
              onPressed: () {
                Get.toNamed(Routes.getAddSlipPageRoute());
              },
              child: Icon(
                Icons.add,
                color: periwinkle,
                size: 32.0,
              )),
          body: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _referralsListItems(index, rVM);
            },
            itemCount: rVM.referralDataList.length,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _referralsListItems(int index, ReferralSlipViewModel rVM) {
    ReferralChildData data = rVM.referralDataList[index];
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
                          Image.asset(contact,
                              height: iconSize18, width: iconSize18),
                          SizedBox(width: paddingSize5),
                          Text(
                            "Contact Number",
                            style: fontRegular.copyWith(
                                fontSize: fontSize12, color: midnightBlue),
                          ),
                        ],
                      ),
                      Text(
                        data.telephone ?? "",
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
                            "Company Name",
                            style: fontRegular.copyWith(
                                fontSize: fontSize12, color: midnightBlue),
                          ),
                        ],
                      ),
                      Text(
                        "Alphabit Infoway",
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
                          Image.asset(businessCat,
                              height: iconSize18, width: iconSize18),
                          SizedBox(width: paddingSize5),
                          Text(
                            "Business Category",
                            style: fontRegular.copyWith(
                                fontSize: fontSize12, color: midnightBlue),
                          ),
                        ],
                      ),
                      Text(
                        "Designing Agency",
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
                            Image.asset(vCard,
                                height: iconSize18, width: iconSize18),
                            SizedBox(width: paddingSize5),
                            Text(
                              "V-Card",
                              style: fontRegular.copyWith(
                                  fontSize: fontSize12, color: midnightBlue),
                            ),
                          ],
                        ),
                        Text(
                            "${data.referralTo?.firstName ?? ""} ${data.referralTo?.lastName ?? ""}",
                            style: fontMedium.copyWith(
                                fontSize: fontSize14, color: midnightBlue)),
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
            data.type ?? "",
            style: fontRegular.copyWith(fontSize: fontSize12, color: greyText),
          ),
          shape: Border(),
          title: Text(
            "${data.referralTo?.firstName ?? ""} ${data.referralTo?.lastName ?? ""}",
            style: fontBold.copyWith(fontSize: fontSize16, color: midnightBlue),
          ),
          onExpansionChanged: (isExpandedItem) {
            rVM.isExpanded.value = isExpandedItem;
          },
          trailing: rVM.isExpanded.value
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
