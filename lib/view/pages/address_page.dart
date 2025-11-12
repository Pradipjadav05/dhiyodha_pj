import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressPage extends StatefulWidget {
  CurrentUserData currentUserData;

  AddressPageState createState() => AddressPageState();

  AddressPage({required this.currentUserData});
}

class AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    super.initState();
    getInitData();
  }

  Future<void> getInitData() async {
    AddressViewmodel addressViewmodel = Get.find<AddressViewmodel>();
    await addressViewmodel.initData();
    await addressViewmodel.getCountries();
    addressViewmodel.addressLine1Controller.text = "";
    addressViewmodel.addressLine2Controller.text = "";
    print("C : ${widget.currentUserData.currentUserAddress?.country}");
    print("S : ${widget.currentUserData.currentUserAddress?.state}");
    print("City : ${widget.currentUserData.currentUserAddress?.city}");
    if (widget.currentUserData.currentUserAddress!.country!.isNotEmpty) {
      await addressViewmodel
          .getStates(widget.currentUserData.currentUserAddress!.country!);
      // addressViewmodel.selectedCountry = "";
      addressViewmodel.selectedCountry =
          widget.currentUserData.currentUserAddress!.country!;
      if (widget.currentUserData.currentUserAddress!.state!.isNotEmpty) {
        addressViewmodel.selectedState =
            widget.currentUserData.currentUserAddress!.state!;
        await addressViewmodel
            .getCities(widget.currentUserData.currentUserAddress!.state!);
        // addressViewmodel.selectedCity = "";
        addressViewmodel.selectedCity =
            widget.currentUserData.currentUserAddress!.city!;
      }
    }
    // addressViewmodel.cityController.text =
    //     widget.currentUserData.currentUserAddress?.city ?? "";
    // addressViewmodel.stateController.text =
    //     widget.currentUserData.currentUserAddress?.state ?? "";
    addressViewmodel.pinCodeController.text =
        widget.currentUserData.currentUserAddress?.pinCode ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            "address".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        body: GetBuilder<AddressViewmodel>(builder: (addressVM) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    controller: addressVM.addressLine1Controller,
                    hintText: "address_1".tr,
                    textStyle: fontMedium.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    controller: addressVM.addressLine2Controller,
                    hintText: "address_2".tr,
                    textStyle: fontMedium.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize25),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize5),
                    decoration: BoxDecoration(
                      color: lavenderMist,
                      borderRadius: BorderRadius.circular(radius10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: const Offset(0, 0))
                      ],
                    ),
                    child: DropdownButton(
                        icon: Image.asset(
                          dropDownArrow,
                          width: 18.0,
                          height: 18.0,
                        ),
                        underline: const SizedBox(),
                        style: fontMedium.copyWith(
                            color: midnightBlue, fontSize: fontSize14),
                        value: addressVM.selectedCountry,
                        isExpanded: true,
                        items: addressVM.countryList.map((String val) {
                          return DropdownMenuItem(
                              child: Text(
                                val,
                                style: fontMedium.copyWith(
                                    color: midnightBlue, fontSize: fontSize14),
                              ),
                              value: val);
                        }).toList(),
                        onChanged: (val) async {
                          addressVM.selectedCountry = val ?? "";
                          addressVM.selectedState = "Select State";
                          addressVM.selectedCity = "Select City";
                          if (addressVM.selectedCountry !=
                              addressVM.countryList[0]) {
                            await addressVM
                                .getStates(addressVM.selectedCountry);
                          }
                          setState(() {});
                        }),
                  ),
                  SizedBox(height: paddingSize25),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize5),
                    decoration: BoxDecoration(
                      color: lavenderMist,
                      borderRadius: BorderRadius.circular(radius10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: const Offset(0, 0))
                      ],
                    ),
                    child: DropdownButton(
                        icon: Image.asset(
                          dropDownArrow,
                          width: 18.0,
                          height: 18.0,
                        ),
                        underline: const SizedBox(),
                        style: fontMedium.copyWith(
                            color: midnightBlue, fontSize: fontSize14),
                        value: addressVM.selectedState,
                        isExpanded: true,
                        items: addressVM.stateList.map((String val) {
                          return DropdownMenuItem(
                              child: Text(
                                val,
                                style: fontMedium.copyWith(
                                    color: midnightBlue, fontSize: fontSize14),
                              ),
                              value: val);
                        }).toList(),
                        onChanged: (val) async {
                          addressVM.selectedState = val.toString() ?? "";
                          addressVM.selectedCity = "Select City";
                          if (addressVM.selectedState !=
                              addressVM.stateList[0]) {
                            await addressVM.getCities(addressVM.selectedState);
                          }
                          setState(() {});
                        }),
                  ),
                  SizedBox(height: paddingSize25),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize5),
                    decoration: BoxDecoration(
                      color: lavenderMist,
                      borderRadius: BorderRadius.circular(radius10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: const Offset(0, 0))
                      ],
                    ),
                    child: DropdownButton(
                        icon: Image.asset(
                          dropDownArrow,
                          width: 18.0,
                          height: 18.0,
                        ),
                        underline: const SizedBox(),
                        style: fontMedium.copyWith(
                            color: midnightBlue, fontSize: fontSize14),
                        value: addressVM.selectedCity,
                        isExpanded: true,
                        items: addressVM.cityList.map((String val) {
                          return DropdownMenuItem(
                              child: Text(
                                val,
                                style: fontMedium.copyWith(
                                    color: midnightBlue, fontSize: fontSize14),
                              ),
                              value: val);
                        }).toList(),
                        onChanged: (val) {
                          addressVM.selectedCity = val!;
                          setState(() {});
                        }),
                  ),
                  // CommonTextFormField(
                  //   controller: addressVM.cityController,
                  //   textStyle:
                  //       fontMedium.copyWith(color: midnightBlue, fontSize: fontSize14),
                  //   hintText: "city".tr,
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: paddingSize20, vertical: paddingSize20),
                  // ),
                  // SizedBox(height: paddingSize25),
                  // CommonTextFormField(
                  //   controller: addressVM.stateController,
                  //   hintText: "state".tr,
                  //   textStyle:
                  //       fontMedium.copyWith(color: midnightBlue, fontSize: fontSize14),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: paddingSize20, vertical: paddingSize20),
                  // ),
                  // SizedBox(height: paddingSize25),

                  // CountryStateCityPicker(
                  //   country: addressVM.countryController,
                  //   state: TextEditingController(),
                  //   city: TextEditingController(),
                  //   textFieldDecoration: InputDecoration(
                  //     isCollapsed: false,
                  //     icon: null,
                  //     counterText: "",
                  //     contentPadding: EdgeInsets.all(12.0),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(radius10),
                  //       borderSide: BorderSide(
                  //           style: BorderStyle.solid,
                  //           width: 0.3,
                  //           color: lavenderMist),
                  //     ),
                  //     disabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(radius10),
                  //       borderSide: BorderSide(
                  //           style: BorderStyle.solid,
                  //           width: 0.3,
                  //           color: lavenderMist),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(radius5),
                  //       borderSide: BorderSide(
                  //           style: BorderStyle.solid,
                  //           width: 0.5,
                  //           color: midnightBlue),
                  //     ),
                  //     border: InputBorder.none,
                  //     isDense: false,
                  //     hintText: "Select Country",
                  //     fillColor: lavenderMist,
                  //     hintStyle: fontRegular.copyWith(
                  //         fontSize: fontSize14, color: midnightBlue),
                  //     filled: true,
                  //   ),
                  // ),
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
                  //   child: CountryStateCityPicker(
                  //     country: addressVM.countryController,
                  //     state: TextEditingController(),
                  //     city: TextEditingController(),
                  //     dialogColor: lavenderMist,
                  //     textFieldDecoration:
                  //   ),
                  // ),
                  // DropdownButton(
                  //     icon: Image.asset(
                  //       dropDownArrow,
                  //       width: 18.0,
                  //       height: 18.0,
                  //     ),
                  //     underline: const SizedBox(),
                  //     style: fontMedium.copyWith(
                  //         color: midnightBlue, fontSize: fontSize14),
                  //     value: 'Country'.tr,
                  //     isExpanded: true,
                  //     items: [],
                  //     onChanged: (val) {})
                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    controller: addressVM.pinCodeController,
                    hintText: "pincode".tr,
                    textStyle: fontMedium.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                    // suffixIcon: Image.asset(location),
                  ),
                  SizedBox(height: paddingSize25),
                  CommonButton(
                    buttonText: "confirm".tr,
                    bgColor: midnightBlue,
                    textColor: periwinkle,
                    onPressed: () async {
                      await collectDataAndSaveProfile(addressVM);
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

  Future<void> collectDataAndSaveProfile(AddressViewmodel addressVM) async {
    if (addressVM.addressLine1Controller.text.isEmpty) {
      showSnackBar("enter_valid_address".tr);
    } else if (addressVM.addressLine2Controller.text.isEmpty) {
      showSnackBar("enter_valid_address".tr);
    } else if (addressVM.selectedCountry.isEmpty ||
        addressVM.selectedCountry == addressVM.countryList[0]) {
      showSnackBar("select_country".tr);
    } else if (addressVM.selectedState.isEmpty ||
        addressVM.selectedState == addressVM.stateList[0]) {
      showSnackBar("select_state".tr);
    } else if (addressVM.selectedCity.isEmpty ||
        addressVM.selectedCity == addressVM.cityList[0]) {
      showSnackBar("select_city".tr);
    } else if (addressVM.pinCodeController.text.isEmpty) {
      showSnackBar("enter_pincode".tr);
    } else {
      UpdateProfileRequestModel userProfileRequestModel =
          new UpdateProfileRequestModel(
        firstName: widget.currentUserData.firstName ?? "",
        lastName: widget.currentUserData.lastName ?? "",
        dob: widget.currentUserData.dob ?? "",
        countryCode: widget.currentUserData.countryCode ?? "",
        mobileNo: widget?.currentUserData?.mobileNo ?? "",
        uploadDocumentId: widget.currentUserData.uploadDocumentId ?? "",
        education: widget.currentUserData.education ?? "",
        children: widget.currentUserData.children ?? 0,
        pet: widget.currentUserData.pet ?? "",
        hobbiesAndInterest: widget.currentUserData.hobbiesAndInterest ?? "",
        cityResidingYears: widget.currentUserData.cityResidingYears ?? 0,
        burningDesire: widget.currentUserData.burningDesire ?? "",
        somethingNoOneKnowsAboutMe:
            widget.currentUserData.somethingNoOneKnowsAboutMe ?? "",
        keyToSuccess: widget.currentUserData.keyToSuccess ?? "",
        residentAddress: addressVM.addressLine1Controller.text ??
            widget.currentUserData.permanentAddress ??
            "",
        permanentAddress: addressVM.addressLine2Controller.text ??
            widget.currentUserData.permanentAddress ??
            "",
        maritalStatus: widget.currentUserData.maritalStatus ?? "",
        previousTypesOfJobs: widget.currentUserData.previousTypesOfJobs ?? "",
        partner: widget.currentUserData.partner ?? "",
        companyDetailsRequest: CompanyDetailsRequest(
            uuid: widget.currentUserData.uuid ?? "",
            companyName:
                widget.currentUserData.currentUserOrganization?.companyName ??
                    "",
            companyEstablishment: widget.currentUserData
                    ?.currentUserOrganization?.companyEstablishment ??
                "",
            companyAddress: addressVM.addressLine2Controller.text ??
                widget
                    .currentUserData?.currentUserOrganization?.companyAddress ??
                "",
            registeredType: widget
                    .currentUserData?.currentUserOrganization?.registeredType ??
                "",
            numberOfEmployees: widget
                .currentUserData?.currentUserOrganization?.numberOfEmployees,
            yearlyTurnover:
                widget.currentUserData?.currentUserOrganization?.yearlyTurnover ??
                    "",
            companyEmail:
                widget.currentUserData?.currentUserOrganization?.companyEmail ??
                    "",
            companyWebsite:
                widget.currentUserData?.currentUserOrganization?.companyWebsite ??
                    "",
            designation:
                widget.currentUserData?.currentUserOrganization?.designation ?? "",
            companyContact: widget.currentUserData?.currentUserOrganization?.companyContact ?? "",
            businessCategory: widget.currentUserData?.currentUserOrganization?.businessCategory ?? "",
            businessDescription: widget.currentUserData?.currentUserOrganization?.businessDescription ?? "",
            yearlyProfit: widget.currentUserData?.currentUserOrganization?.yearlyProfit,
            gstNumber: widget.currentUserData?.currentUserOrganization?.gstNumber ?? "",
            uploadGst: widget.currentUserData?.currentUserOrganization?.uploadGst ?? "",
            panNumber: widget.currentUserData?.currentUserOrganization?.panNumber ?? "",
            uploadPan: widget.currentUserData?.currentUserOrganization?.uploadPan ?? ""),
        addressRequest: AddressRequest(
          city: addressVM.selectedCity ??
              widget.currentUserData.currentUserAddress?.city ??
              "",
          state: addressVM.selectedState ??
              widget.currentUserData.currentUserAddress?.state ??
              "",
          country: addressVM.selectedCountry ??
              widget.currentUserData.currentUserAddress?.country ??
              "",
          pinCode: addressVM.pinCodeController.text ??
              widget.currentUserData.currentUserAddress?.pinCode ??
              "",
        ),
      );
      bool resp = await addressVM.updateProfile(userProfileRequestModel);
      if (resp) {
        Get.back(result: true, canPop: true, closeOverlays: true);
        showSnackBar("profile_updated".tr, isError: false);
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
