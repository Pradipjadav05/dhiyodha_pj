import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/one_to_one_slip_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOneToOneSlipPage extends StatefulWidget {
  AddOneToOneSlipPageState createState() => AddOneToOneSlipPageState();
}

class AddOneToOneSlipPageState extends State<AddOneToOneSlipPage> {
  @override
  void initState() {
    super.initState();
    Get.find<OneToOneSlipViewModel>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text("one_slip".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: GetBuilder<OneToOneSlipViewModel>(
            builder: (ovm) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: paddingSize25),
                  // InkWell(
                  //   onTap: () async {},
                  //   child: CommonTextFormField(
                  //     hintText: "upload_photo".tr,
                  //     hintColor: midnightBlue,
                  //     textStyle: fontRegular.copyWith(
                  //         color: midnightBlue, fontSize: fontSize14),
                  //     suffixIcon: Image.asset(postUpload),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: paddingSize20, vertical: paddingSize20),
                  //   ),
                  // ),
                  SizedBox(height: paddingSize25),
                  InkWell(
                    onTap: () async {
                      MembersChildData childData =
                          await Get.toNamed(Routes.getMembersPageRoute("true"));
                      //ovm.selectedMemberId = childData.uuid ?? "";
                      ovm.metWithController.text =
                          '${childData.firstName} ${childData.lastName}';
                    },
                    child: CommonTextFormField(
                        isEnabled: false,
                        controller: ovm.metWithController,
                        hintText: "met_with".tr,
                        hintColor: midnightBlue,
                        textStyle: fontRegular.copyWith(
                            color: midnightBlue, fontSize: fontSize14),
                        suffixIcon: Image.asset(searchBlue),
                        padding: const EdgeInsets.symmetric(
                            horizontal: paddingSize20,
                            vertical: paddingSize20)),
                  ),
                  SizedBox(height: paddingSize25),
                  // CommonDropDown(
                  //     value: "initiated_by".tr,
                  //     title: "",
                  //     dataList: [],
                  //     onChanged: (value) {}),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: paddingSize20, vertical: paddingSize5),
                  //   decoration: BoxDecoration(
                  //     color: lavenderMist,
                  //     borderRadius: BorderRadius.circular(radius10),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.grey,
                  //           spreadRadius: 0,
                  //           blurRadius: 0,
                  //           offset: const Offset(0, 0))
                  //     ],
                  //   ),
                  //   child: DropdownButton(
                  //       icon: Image.asset(
                  //         dropDownArrow,
                  //         width: 18.0,
                  //         height: 18.0,
                  //       ),
                  //       underline: const SizedBox(),
                  //       style: fontRegular.copyWith(
                  //           color: midnightBlue, fontSize: fontSize14),
                  //       value: ovm.selectedInitiatedBy,
                  //       isExpanded: true,
                  //       items: [
                  //         DropdownMenuItem(
                  //           child: Text(
                  //             ovm.selectedInitiatedBy,
                  //             style: fontRegular.copyWith(
                  //                 color: midnightBlue, fontSize: fontSize14),
                  //           ),
                  //           value: ovm.selectedInitiatedBy,
                  //         )
                  //       ],
                  //       onChanged: (val) {}),
                  // ),
                  // SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    controller: ovm.whereMeetController,
                    hintText: "where_meet".tr,
                    textStyle: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize25),
                  InkWell(
                    onTap: () async {
                      await ovm.selectDate(context);
                    },
                    child: CommonTextFormField(
                      controller: ovm.whenMeetController,
                      hintText: "select_date_time".tr,
                      isEnabled: false,
                      textStyle: fontRegular.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                  ),

                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    controller: ovm.conversionTopicController,
                    maxLines: 4,
                    hintText: "topics_of_conversation".tr,
                    textStyle: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize25),
                  CommonButton(
                    buttonText: "confirm".tr,
                    bgColor: midnightBlue,
                    textColor: periwinkle,
                    onPressed: () async {
                      await _collectDataAndAddReferrals(ovm);
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _collectDataAndAddReferrals(OneToOneSlipViewModel ovm) async {
    if (ovm.metWithController.text.isEmpty) {
      showSnackBar("select_connected_with".tr);
    } else if (ovm.whereMeetController.text.isEmpty) {
      showSnackBar("select_meeting_location".tr);
    } else if (ovm.whenMeetController.text.isEmpty) {
      showSnackBar("select_meeting_date_time".tr);
    } else if (ovm.conversionTopicController.text.isEmpty) {
      showSnackBar("add_topic".tr);
    } else {
      bool isSuccess = await ovm.addOneToOneData(
          ovm.metWithController.text.toString(),
          "SELF",
          ovm.location,
          ovm.whenMeetController.text.toString(),
          ovm.conversionTopicController.text.toString());
      if (isSuccess) {
        showSnackBar("one_to_one_added".tr, isError: false);
        ovm.initData();
      } else {
        showSnackBar('errorMessage'.tr);
      }
    }
  }
}
