import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:dhiyodha/model/response_model/tyfcb_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/view/widgets/common_text_label.dart';
import 'package:dhiyodha/viewModel/one_to_one_slip_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/resource/app_constants.dart';

class AddOneToOneSlipPage extends StatefulWidget {
  const AddOneToOneSlipPage({Key? key}) : super(key: key);

  @override
  AddOneToOneSlipPageState createState() => AddOneToOneSlipPageState();
}

class AddOneToOneSlipPageState extends State<AddOneToOneSlipPage> {
  @override
  void initState() {
    super.initState();
    // ✅ Defer initData to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<OneToOneSlipViewModel>().initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            'one_to_one_slip'.tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        body: GetBuilder<OneToOneSlipViewModel>(
          builder: (addOVM) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: paddingSize20),

                    // ── Met With ──
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                          labelText: 'met_with'.tr,
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize25,
                              vertical: paddingSize8),
                        ),
                        Expanded(child: Divider(height: 1.0, color: divider)),
                      ],
                    ),
                    const SizedBox(height: paddingSize15),
                    InkWell(
                      onTap: () async {
                        final MembersChildData childData = await Get.toNamed(
                            Routes.getMembersPageRoute('true'));
                        addOVM.metWithController.text =
                            '${childData.firstName} ${childData.lastName}';

                        if (globalCurrentUserData.currentUserRoles?[0].uuid ==
                            childData.uuid) {
                          addOVM.initiatedBy = "SELF";
                        } else {
                          addOVM.initiatedBy = "OTHER";
                        }

                        setState(() {});
                      },
                      child: CommonTextFormField(
                        isEnabled: false,
                        controller: addOVM.metWithController,
                        hintText: 'met_with'.tr,
                        hintColor: midnightBlue,
                        suffixIcon: Image.asset(search, color: bluishPurple),
                        padding: const EdgeInsets.symmetric(
                            horizontal: paddingSize20, vertical: paddingSize20),
                      ),
                    ),

                    const SizedBox(height: paddingSize25),

                    // ── Initiated By ──
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                          labelText: 'initiated_by'.tr,
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize25,
                              vertical: paddingSize8),
                        ),
                        Expanded(child: Divider(height: 1.0, color: divider)),
                      ],
                    ),
                    const SizedBox(height: paddingSize15),
                    InkWell(
                      onTap: () async {
                        final MembersChildData childData = await Get.toNamed(
                            Routes.getMembersPageRoute('true'));
                        addOVM.selectedInitiatedBy =
                            '${childData.firstName} ${childData.lastName}';
                        addOVM.connectedWith = childData.uuid!;
                        setState(() {});
                      },
                      child: CommonTextFormField(
                        isEnabled: false,
                        controller: TextEditingController(
                            text:
                                addOVM.selectedInitiatedBy == 'Initiated By' ||
                                        addOVM.selectedInitiatedBy.isEmpty
                                    ? ''
                                    : addOVM.selectedInitiatedBy),
                        hintText: 'initiated_by'.tr,
                        hintColor: midnightBlue,
                        suffixIcon: Image.asset(search, color: bluishPurple),
                        padding: const EdgeInsets.symmetric(
                            horizontal: paddingSize20, vertical: paddingSize20),
                      ),
                    ),

                    const SizedBox(height: paddingSize25),

                    // ── Where ──
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                          labelText: 'where'.tr,
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize25,
                              vertical: paddingSize8),
                        ),
                        Expanded(child: Divider(height: 1.0, color: divider)),
                      ],
                    ),
                    const SizedBox(height: paddingSize15),
                    CommonTextFormField(
                      controller: addOVM.whereMeetController,
                      hintText: 'where'.tr,
                      hintColor: midnightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),

                    const SizedBox(height: paddingSize25),

                    // ── When ──
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                          labelText: 'when'.tr,
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize25,
                              vertical: paddingSize8),
                        ),
                        Expanded(child: Divider(height: 1.0, color: divider)),
                      ],
                    ),
                    const SizedBox(height: paddingSize15),
                    InkWell(
                      onTap: () async {
                        await addOVM.selectDate(context);
                        setState(() {});
                      },
                      child: CommonTextFormField(
                        isEnabled: false,
                        controller: addOVM.whenMeetController,
                        hintText: 'when'.tr,
                        hintColor: midnightBlue,
                        suffixIcon: Icon(Icons.calendar_today,
                            color: bluishPurple, size: iconSize18),
                        padding: const EdgeInsets.symmetric(
                            horizontal: paddingSize20, vertical: paddingSize20),
                      ),
                    ),

                    const SizedBox(height: paddingSize25),

                    // ── Conversation Topics ──
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                          labelText: 'topics_of_conversation'.tr,
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize25,
                              vertical: paddingSize8),
                        ),
                        Expanded(child: Divider(height: 1.0, color: divider)),
                      ],
                    ),
                    const SizedBox(height: paddingSize15),
                    CommonTextFormField(
                      controller: addOVM.conversionTopicController,
                      hintText: 'topics_of_conversation'.tr,
                      hintColor: midnightBlue,
                      maxLines: 4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),

                    const SizedBox(height: paddingSize25),

                    // ── Submit ──
                    CommonButton(
                      buttonText: 'confirm'.tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () async {
                        await _submit(addOVM);
                      },
                    ),

                    const SizedBox(height: paddingSize25),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _submit(OneToOneSlipViewModel addOVM) async {
    if (addOVM.metWithController.text.isEmpty) {
      showSnackBar('select_met_with'.tr);
    } else if (addOVM.selectedInitiatedBy == 'Initiated By' ||
        addOVM.selectedInitiatedBy.isEmpty) {
      showSnackBar('select_initiated_by'.tr);
    } else if (addOVM.whereMeetController.text.isEmpty) {
      showSnackBar('enter_where'.tr);
    } else if (addOVM.whenMeetController.text.isEmpty) {
      showSnackBar('select_when'.tr);
    } else if (addOVM.conversionTopicController.text.isEmpty) {
      showSnackBar('enter_topics'.tr);
    } else {
      final bool isSuccess = await addOVM.addOneToOneData(
        //todo: meetingUuid
        "",
        addOVM.connectedWith,
        addOVM.initiatedBy,
        addOVM.location,
        DateFormat("yyyy-MM-dd").format(addOVM.selectedDate),
        addOVM.conversionTopicController.text,
        // locationName
        addOVM.whereMeetController.text,
        "${globalCurrentUserData.firstName} ${globalCurrentUserData.lastName}",
      );

      if (isSuccess) {
        showSnackBar('one_to_one_added'.tr, isError: false);
        Get.back();
      } else {
        showSnackBar('errorMessage'.tr);
      }
    }
  }
}
