import 'package:dhiyodha/model/response_model/response_model.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/asks_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAskPage extends StatefulWidget {
  AddAskPageState createState() => AddAskPageState();
}

class AddAskPageState extends State<AddAskPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text(
          "add_ask".tr,
          style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(paddingSize14),
            child: GetBuilder<AsksViewModel>(builder: (askVM) {
              return Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "select_ask_type".tr,
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: 1,
                          groupValue: askVM.selectedAsTypeVal.value,
                          onChanged: (int? value) {
                            askVM.setSelectedAsTypeVal(value!);
                            askVM.askTypeValue.value = "Specific".toUpperCase();
                          },
                          activeColor: bluishPurple,
                        ),
                        Text(
                          "specific".tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: 2,
                          groupValue: askVM.selectedAsTypeVal.value,
                          onChanged: (int? value) {
                            askVM.setSelectedAsTypeVal(value!);
                            askVM.askTypeValue.value = "General".toUpperCase();
                          },
                          activeColor: bluishPurple,
                        ),
                        Text(
                          "general".tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: 3,
                          groupValue: askVM.selectedAsTypeVal.value,
                          onChanged: (int? value) {
                            askVM.setSelectedAsTypeVal(value!);
                            askVM.askTypeValue.value = "Personal".toUpperCase();
                          },
                          activeColor: bluishPurple,
                        ),
                        Text(
                          "personal".tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "select_region".tr,
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: 1,
                          groupValue: askVM.selectedRegionVal.value,
                          onChanged: (int? value) {
                            askVM.setSelectedRegionVal(value!);
                            askVM.regionValue.value = "Chapter".toUpperCase();
                          },
                          activeColor: bluishPurple,
                        ),
                        Text(
                          "chapter".tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: 2,
                          groupValue: askVM.selectedRegionVal.value,
                          onChanged: (int? value) {
                            askVM.setSelectedRegionVal(value!);
                            askVM.regionValue.value =
                                "City_region".toUpperCase();
                          },
                          activeColor: bluishPurple,
                        ),
                        Text(
                          "city".tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                    SizedBox(height: paddingSize20),
                    CommonTextFormField(
                      controller: askVM.contentController,
                      bgColor: lavenderMist,
                      maxLines: 4,
                      hintText: "write_ask".tr,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    SizedBox(height: paddingSize55),
                    CommonButton(
                      buttonText: "submit".tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () async {
                        if (askVM.contentController.text.isNotEmpty) {
                          ResponseModel resp = await askVM.addAsks(
                              askVM.askTypeValue.value,
                              askVM.regionValue.value,
                              askVM.contentController.text);
                          if (resp.isSuccess) {
                            Get.back(result: resp, closeOverlays: true);
                          } else {
                            showSnackBar(resp.message);
                          }
                        } else {
                          showSnackBar("ask_content_required".tr);
                        }
                      },
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
