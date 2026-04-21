import 'package:dhiyodha/model/response_model/ask_list_response_model.dart';
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

class ConnectWithAskPage extends StatefulWidget {
  AskListChild askChild;

  ConnectWithAskPageState createState() => ConnectWithAskPageState();

  ConnectWithAskPage({required this.askChild});
}

class ConnectWithAskPageState extends State<ConnectWithAskPage> {
  @override
  void initState() {
    super.initState();
    Get.find<AsksViewModel>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text(
          "Connect to Ask".tr,
          style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<AsksViewModel>(builder: (askVM) {
            return Padding(
              padding: const EdgeInsets.all(paddingSize14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: paddingSize15),
                  Text(
                    "contact_name".tr,
                    style: fontMedium.copyWith(
                        color: bluishPurple, fontSize: fontSize14),
                  ),
                  SizedBox(height: paddingSize5),
                  CommonTextFormField(
                    controller: askVM.nameController,
                    bgColor: lavenderMist,
                    hintText: "contact_name".tr,
                    hintColor: midnightBlue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize15),
                  Text(
                    "contact_number".tr,
                    style: fontMedium.copyWith(
                        color: bluishPurple, fontSize: fontSize14),
                  ),
                  SizedBox(height: paddingSize5),
                  CommonTextFormField(
                    controller: askVM.contactController,
                    inputType: TextInputType.number,
                    maxLength: 10,
                    bgColor: lavenderMist,
                    hintText: "contact_number".tr,
                    hintColor: midnightBlue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                    // suffixIcon: Image.asset(contact),
                  ),
                  SizedBox(height: paddingSize15),
                  Text(
                    "comments".tr,
                    style: fontMedium.copyWith(
                        color: bluishPurple, fontSize: fontSize14),
                  ),
                  SizedBox(height: paddingSize5),
                  CommonTextFormField(
                    controller: askVM.commentsController,
                    bgColor: lavenderMist,
                    hintColor: midnightBlue,
                    maxLines: 4,
                    hintText: "comments".tr,
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize55),
                  askVM.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : CommonButton(
                          buttonText: "submit".tr,
                          bgColor: midnightBlue,
                          textColor: periwinkle,
                          onPressed: () async {
                            ///await addAskReply(askVM);
                            if (askVM.commentsController.text.isEmpty) {
                              showSnackBar("ask_ans_required".tr);
                            } else if (askVM.contactController.text.isEmpty ||
                                askVM.contactController.text.length < 10) {
                              showSnackBar("valid_number".tr);
                            } else if (askVM.nameController.text.isEmpty) {
                              showSnackBar("enter_name".tr);
                            } else {
                              await addAskReply(askVM);
                            }
                          },
                        ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> addAskReply(AsksViewModel askVM) async {
    ResponseModel responseModel = await askVM.addAsksReply(
        widget.askChild.askUuid ?? "", askVM.commentsController.text);
    if (responseModel.isSuccess) {
      Get.back(closeOverlays: true, canPop: true);
      showSnackBar(responseModel.message, isError: false);
    } else {
      showSnackBar(responseModel.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
