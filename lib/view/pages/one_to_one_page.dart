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
  OneToOnePageState createState() => OneToOnePageState();
}

class OneToOnePageState extends State<OneToOnePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<OneToOneSlipViewModel>(builder: (oVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "One-to-One Slip".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              tooltip: "Add One-to-One",
              elevation: 4.0,
              backgroundColor: midnightBlue,
              onPressed: () {
                Get.toNamed(Routes.getAddOneToOnePageRoute());
              },
              child: Icon(
                Icons.add,
                color: periwinkle,
                size: 32.0,
              )),
          body: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _oneToOneListItems(index, oVM);
            },
            itemCount: 30,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _oneToOneListItems(int index, OneToOneSlipViewModel oVM) {
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
                        "+91 98989 51211",
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
                          "Kevin Patel",
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
            "Graphic Designer",
            style: fontRegular.copyWith(fontSize: fontSize12, color: greyText),
          ),
          shape: Border(),
          title: Text(
            "Kevin Patel",
            style: fontBold.copyWith(fontSize: fontSize16, color: midnightBlue),
          ),
          onExpansionChanged: (isExpandedItem) {
            oVM.isExpanded.value = isExpandedItem;
          },
          trailing: oVM.isExpanded.value
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
