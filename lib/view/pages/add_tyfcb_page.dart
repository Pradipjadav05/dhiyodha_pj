import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:dhiyodha/model/response_model/response_model.dart';
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
import 'package:dhiyodha/viewModel/tyfcb_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTyPage extends StatefulWidget {
  AddTyPageState createState() => AddTyPageState();
}

class AddTyPageState extends State<AddTyPage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await Get.find<TyfcbViewModel>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            "add_tyfcb".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        body: GetBuilder<TyfcbViewModel>(builder: (addTyVM) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: addTyVM.isLoading,
                    child: LinearProgressIndicator(
                      color: midnightBlue,
                      backgroundColor: lavenderMist,
                      borderRadius: BorderRadius.circular(radius20),
                    ),
                  ),
                  SizedBox(height: paddingSize25),
                  InkWell(
                    onTap: () async {
                      MembersChildData childData =
                          await Get.toNamed(Routes.getMembersPageRoute("true"));
                      addTyVM.selectedMemberId = childData.uuid ?? "";
                      addTyVM.tyfcbToController.text =
                          '${childData.firstName} ${childData.lastName}';
                    },
                    child: CommonTextFormField(
                      isEnabled: false,
                      controller: addTyVM.tyfcbToController,
                      hintText: "thank_you_to".tr,
                      textStyle: fontMedium.copyWith(
                          fontSize: fontSize14, color: midnightBlue),
                      hintColor: midnightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                      suffixIcon: Image.asset(search),
                    ),
                  ),
                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    controller: addTyVM.amountController,
                    hintText: "amount".tr,
                    hintColor: midnightBlue,
                    prefixIcon: Image.asset(
                      rsSymbol,
                      width: 18.0,
                      height: 18.0,
                      color: bluishPurple,
                    ),
                    isIconDivider: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize25),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonTextLabel(
                        labelText: "business_type".tr,
                        padding: const EdgeInsets.symmetric(
                            horizontal: paddingSize25, vertical: paddingSize10),
                      ),
                      Expanded(
                        child: Divider(
                          height: 1.0,
                          color: divider,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: paddingSize15),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CommonCard(
                            elevation: 2.0,
                            bgColor: addTyVM.businessTypeNew.value
                                ? bluishPurple
                                : lavenderMist,
                            onTap: () async {
                              addTyVM.businessTypeRepeat.value = false;
                              addTyVM.businessTypeNew.value = true;
                            },
                            cardChild: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize15,
                                  vertical: paddingSize10),
                              child: Center(
                                child: Text(
                                  "new".tr,
                                  style: fontMedium.copyWith(
                                      color: addTyVM.businessTypeNew.value
                                          ? white
                                          : midnightBlue,
                                      fontSize: fontSize14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CommonCard(
                            elevation: 2.0,
                            bgColor: addTyVM.businessTypeRepeat.value
                                ? bluishPurple
                                : lavenderMist,
                            onTap: () {
                              addTyVM.businessTypeRepeat.value = true;
                              addTyVM.businessTypeNew.value = false;
                            },
                            cardChild: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize15,
                                  vertical: paddingSize10),
                              child: Center(
                                child: Text(
                                  "repeat".tr,
                                  style: fontMedium.copyWith(
                                      color: addTyVM.businessTypeRepeat.value
                                          ? white
                                          : midnightBlue,
                                      fontSize: fontSize14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: paddingSize15),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonTextLabel(
                        labelText: "referral_type".tr,
                        padding: const EdgeInsets.symmetric(
                            horizontal: paddingSize25, vertical: paddingSize10),
                      ),
                      Expanded(
                        child: Divider(
                          height: 1.0,
                          color: divider,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: paddingSize15),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CommonCard(
                            elevation: 2.0,
                            bgColor: addTyVM.referralTypeInside.value
                                ? bluishPurple
                                : lavenderMist,
                            onTap: () {
                              addTyVM.referralTypeInside.value = true;
                              addTyVM.referralTypeOutside.value = false;
                              addTyVM.referralTypeTire.value = false;
                            },
                            cardChild: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize15,
                                  vertical: paddingSize10),
                              child: Center(
                                child: Text(
                                  "inside".tr,
                                  style: fontMedium.copyWith(
                                      color: addTyVM.referralTypeInside.value
                                          ? white
                                          : midnightBlue,
                                      fontSize: fontSize14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CommonCard(
                            elevation: 2.0,
                            bgColor: addTyVM.referralTypeOutside.value
                                ? bluishPurple
                                : lavenderMist,
                            onTap: () {
                              addTyVM.referralTypeInside.value = false;
                              addTyVM.referralTypeOutside.value = true;
                              addTyVM.referralTypeTire.value = false;
                            },
                            cardChild: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize15,
                                  vertical: paddingSize10),
                              child: Center(
                                child: Text(
                                  "outside".tr,
                                  style: fontMedium.copyWith(
                                      color: addTyVM.referralTypeOutside.value
                                          ? white
                                          : midnightBlue,
                                      fontSize: fontSize14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CommonCard(
                            elevation: 2.0,
                            bgColor: addTyVM.referralTypeTire.value
                                ? bluishPurple
                                : lavenderMist,
                            onTap: () {
                              addTyVM.referralTypeInside.value = false;
                              addTyVM.referralTypeOutside.value = false;
                              addTyVM.referralTypeTire.value = true;
                            },
                            cardChild: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize15,
                                  vertical: paddingSize10),
                              child: Center(
                                child: Text(
                                  "tire3+".tr,
                                  style: fontMedium.copyWith(
                                      color: addTyVM.referralTypeTire.value
                                          ? white
                                          : midnightBlue,
                                      fontSize: fontSize14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    controller: addTyVM.commentsController,
                    maxLines: 4,
                    hintText: "comments".tr,
                    hintColor: midnightBlue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize25),
                  CommonButton(
                    buttonText: "confirm".tr,
                    bgColor: midnightBlue,
                    textColor: periwinkle,
                    onPressed: () async {
                      await _collectDataAndSave(addTyVM);
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _collectDataAndSave(TyfcbViewModel addTyVM) async {
    var selectedBusinessType = addTyVM.businessTypeNew.value ? "New" : "Repeat";
    var selectedReferralsType = addTyVM.referralTypeInside.value
        ? "Inside"
        : addTyVM.referralTypeOutside.value
            ? "Outside"
            : "Tire3+";
    if (addTyVM.tyfcbToController.text.isEmpty) {
      showSnackBar("add_person".tr);
    } else if (addTyVM.amountController.text.isEmpty) {
      showSnackBar("enter_amount".tr);
    } else if (addTyVM.commentsController.text.isEmpty) {
      showSnackBar("please_enter_comment".tr);
    } else {
      ResponseModel resp = await addTyVM.createAppreciateNote(
          addTyVM.selectedMemberId,
          addTyVM.amountController.text,
          selectedBusinessType.toUpperCase(),
          selectedReferralsType.toUpperCase(),
          addTyVM.commentsController.text);
      if (resp.isSuccess) {
        Get.back(result: true, canPop: true, closeOverlays: true);
        showSnackBar(resp.message, isError: false);
      } else {
        showSnackBar('errorMessage'.tr);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
