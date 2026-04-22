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
import 'package:flutter_contacts/flutter_contacts.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AsksViewModel>().initData();
    });
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
                    suffixIcon: IconButton(
                      tooltip: "pick_from_contacts".tr,
                      padding: EdgeInsets.only(right: 10),
                      onPressed: askVM.isContactLoading.value
                          ? null
                          : () => _openContactPicker(askVM),
                      icon: askVM.isContactLoading.value
                          ? SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: midnightBlue,
                              ),
                            )
                          : Icon(
                              Icons.contacts_outlined,
                              color: midnightBlue,
                            ),
                    ),
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

  Future<void> _openContactPicker(AsksViewModel askVM) async {
    final bool granted = await askVM.loadContacts();
    if (!mounted) {
      return;
    }
    if (!granted) {
      showSnackBar("contact_permission_denied".tr);
      return;
    }

    if (askVM.contacts.isEmpty) {
      showSnackBar("no_contacts_found".tr);
      return;
    }

    askVM.setContactSearchQuery('');
    await Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: ghostWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius20)),
        ),
        padding: EdgeInsets.only(
          left: paddingSize14,
          right: paddingSize14,
          top: paddingSize14,
          bottom: MediaQuery.of(context).viewInsets.bottom + paddingSize14,
        ),
        child: SafeArea(
          top: false,
          child: GetBuilder<AsksViewModel>(builder: (sheetVM) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "pick_from_contacts".tr,
                        style: fontBold.copyWith(
                          fontSize: fontSize18,
                          color: midnightBlue,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: Get.back,
                      icon: Icon(Icons.close, color: midnightBlue),
                    )
                  ],
                ),
                SizedBox(height: paddingSize10),
                CommonTextFormField(
                  hintText: "search_contacts".tr,
                  prefixIcon: Icon(Icons.search, color: bluishPurple),
                  bgColor: white,
                  hintColor: midnightBlue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: paddingSize20,
                    vertical: paddingSize15,
                  ),
                  onChanged: (value) =>
                      sheetVM.setContactSearchQuery(value.toString()),
                ),
                SizedBox(height: paddingSize10),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: Get.height * 0.55,
                  ),
                  child: sheetVM.filteredContacts.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: paddingSize30,
                            ),
                            child: Text(
                              "no_contacts_found".tr,
                              style: fontRegular.copyWith(
                                fontSize: fontSize14,
                                color: midnightBlue,
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: sheetVM.filteredContacts.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(height: paddingSize10),
                          itemBuilder: (context, index) {
                            final Contact contact =
                                sheetVM.filteredContacts[index];
                            final String number = contact.phones.isNotEmpty
                                ? contact.phones.first.number
                                : '';
                            final String initial = contact.displayName.isNotEmpty
                                ? contact.displayName[0].toUpperCase()
                                : '?';
                            return InkWell(
                              onTap: () {
                                sheetVM.applyContact(contact);
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(radius15),
                                  border: Border.all(color: lavenderMist),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize14,
                                  vertical: paddingSize10,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundColor: midnightBlue,
                                      child: Text(
                                        initial,
                                        style: fontBold.copyWith(
                                          color: periwinkle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: paddingSize10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contact.displayName,
                                            style: fontMedium.copyWith(
                                              fontSize: fontSize14,
                                              color: midnightBlue,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: paddingSize5),
                                          Text(
                                            number,
                                            style: fontRegular.copyWith(
                                              fontSize: fontSize13,
                                              color: bluishPurple,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: bluishPurple,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
