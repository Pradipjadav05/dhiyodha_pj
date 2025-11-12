import 'package:dhiyodha/model/response_model/visitor_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/viewModel/visitors_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

class VisitorPage extends StatefulWidget {
  VisitorPageState createState() => VisitorPageState();
}

class VisitorPageState extends State<VisitorPage> {
  @override
  void initState() {
    super.initState();
    setupInitialData();
  }

  Future<void> setupInitialData() async {
    VisitorsViewModel vvm = Get.find<VisitorsViewModel>();
    await vvm.initData();
    await vvm.getVisitors(vvm.page.value, vvm.size.value, "", "", "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<VisitorsViewModel>(builder: (visitorVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "visitors".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              tooltip: "add_visitor".tr,
              elevation: 4.0,
              backgroundColor: midnightBlue,
              onPressed: () {
                Get.toNamed(Routes.getAddVisitorPageRoute());
              },
              child: Icon(
                Icons.add,
                color: periwinkle,
                size: 32.0,
              )),
          body: Column(
            children: [
              Visibility(
                visible: visitorVM.isLoading,
                child: LinearProgressIndicator(
                  color: midnightBlue,
                  backgroundColor: lavenderMist,
                  borderRadius: BorderRadius.circular(radius20),
                ),
              ),
              visitorVM.visitorData.isNotEmpty
                  ? Expanded(
                      child: LoadMore(
                          isFinish: visitorVM.page.value ==
                              visitorVM.totalPages.value,
                          whenEmptyLoad: true,
                          delegate: const DefaultLoadMoreDelegate(),
                          textBuilder: DefaultLoadMoreTextBuilder.english,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _visitorsListItems(index, visitorVM);
                            },
                            itemCount: visitorVM.visitorData.length,
                          ),
                          onLoadMore: visitorVM.loadMore))
                  : Expanded(
                      child: Center(
                        child: Text(
                          "no_visitors".tr,
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize18),
                        ),
                      ),
                    ),
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

  _visitorsListItems(int index, VisitorsViewModel visitorVM) {
    VisitorChildData data = visitorVM.visitorData[index];
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
                            "contact_number".tr,
                            style: fontRegular.copyWith(
                                fontSize: fontSize12, color: midnightBlue),
                          ),
                        ],
                      ),
                      Text(
                        "${data.contactNumber}",
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
                            "company_name".tr,
                            style: fontRegular.copyWith(
                                fontSize: fontSize12, color: midnightBlue),
                          ),
                        ],
                      ),
                      Text(
                        "${data.companyName}",
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
                            "business_category".tr,
                            style: fontRegular.copyWith(
                                fontSize: fontSize12, color: midnightBlue),
                          ),
                        ],
                      ),
                      Text(
                        "${data.businessCategory}",
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
                  onTap: () {
                    Get.toNamed(
                        Routes.getVisitingCardPageRoute(visitorData: data));
                  },
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
                              "v_card".tr,
                              style: fontRegular.copyWith(
                                  fontSize: fontSize12, color: midnightBlue),
                            ),
                          ],
                        ),
                        Text(
                          "${data.name}",
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
            "${data.title}",
            style: fontRegular.copyWith(fontSize: fontSize12, color: greyText),
          ),
          shape: Border(),
          title: Text(
            "${data.name}",
            style: fontBold.copyWith(fontSize: fontSize16, color: midnightBlue),
          ),
          onExpansionChanged: (isExpandedItem) {
            visitorVM.isExpanded.value = isExpandedItem;
          },
          trailing: visitorVM.isExpanded.value
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
