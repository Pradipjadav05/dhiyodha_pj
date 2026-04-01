import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/view/pages/visitor/visitor_list_page.dart';
import 'package:dhiyodha/view/pages/visitor/visitor_page.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/viewModel/visitors_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/common_button.dart';
import 'add_visitors_page.dart';

class AddVisitorsPage extends StatefulWidget {
  AddVisitorsPageState createState() => AddVisitorsPageState();
}

class AddVisitorsPageState extends State<AddVisitorsPage> {

  var isListScreen = true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    VisitorsViewModel vvm = Get.find<VisitorsViewModel>();
    await vvm.initData();
    await vvm.getCountries();
    await vvm.getBusinessCategories();
    await vvm.getMeetingsList();
    await vvm.getGroups(vvm.page.value, vvm.size.value, "", "", "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<VisitorsViewModel>(builder: (vvm) {
      return Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            "add_visitor".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(paddingSize10),
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      buttonText: "meeting_visitor".tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () async {
                        setState(() {
                          isListScreen = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: paddingSize10,
                  ),
                  Expanded(
                    child: CommonButton(
                      buttonText: "add_visitor".tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () async {
                        setState(() {
                          isListScreen = false;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: isListScreen,
              child: Expanded(child: VisitorPage(
                isAppBarRequired: false,
                onStateChanged: () {
                  setState(() {
                    isListScreen = false;
                  });
                },
              )),
            ),
            Visibility(
              visible: !isListScreen,
              child: Expanded(child: AddVisitorFormWidget(
                visitorsViewModel: vvm,
                onStateChanged: () {
                  setState(() {});
                },
              )),
            ),
          ],
        ),
      );
    }));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
