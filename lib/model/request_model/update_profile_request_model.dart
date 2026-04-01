import '../response_model/current_user_response_model.dart';

class UpdateProfileRequestModel {
  String? firstName;
  String? lastName;
  String? dob;
  String? countryCode;
  String? mobileNo;
  String? uploadDocumentId;
  String? education;
  String? previousTypesOfJobs;
  String? partner;
  int? children;
  String? pet;
  String? hobbiesAndInterest;
  int? cityResidingYears;
  String? burningDesire;
  String? somethingNoOneKnowsAboutMe;
  String? keyToSuccess;
  String? residentAddress;
  String? permanentAddress;
  String? profileUrl;
  String? maritalStatus;
  CompanyDetailsRequest? businessDetailsResponse;
  AddressRequest? addressRequest;

  UpdateProfileRequestModel(
      {this.firstName,
      this.lastName,
      this.dob,
      this.countryCode,
      this.mobileNo,
      this.uploadDocumentId,
      this.education,
      this.previousTypesOfJobs,
      this.partner,
      this.children,
      this.pet,
      this.hobbiesAndInterest,
      this.cityResidingYears,
      this.burningDesire,
      this.somethingNoOneKnowsAboutMe,
      this.keyToSuccess,
      this.residentAddress,
      this.permanentAddress,
      this.profileUrl,
      this.maritalStatus,
      this.businessDetailsResponse,
      this.addressRequest});

  UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'];
    countryCode = json['countryCode'];
    mobileNo = json['mobileNo'];
    uploadDocumentId = json['uploadDocumentId'];
    education = json['education'];
    previousTypesOfJobs = json['previousTypesOfJobs'];
    partner = json['partner'];
    children = json['children'];
    pet = json['pet'];
    hobbiesAndInterest = json['hobbiesAndInterest'];
    cityResidingYears = json['cityResidingYears'];
    burningDesire = json['burningDesire'];
    somethingNoOneKnowsAboutMe = json['somethingNoOneKnowsAboutMe'];
    keyToSuccess = json['keyToSuccess'];
    residentAddress = json['residentAddress'];
    permanentAddress = json['permanentAddress'];
    profileUrl = json['profileUrl'];
    maritalStatus = json['maritalStatus'];
    businessDetailsResponse = json['businessDetailsResponse'] != null
        ? new CompanyDetailsRequest.fromJson(json['businessDetailsResponse'])
        : null;
    addressRequest = json['address'] != null
        ? new AddressRequest.fromJson(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['dob'] = dob;
    data['countryCode'] = countryCode;
    data['mobileNo'] = mobileNo;
    data['uploadDocumentId'] = uploadDocumentId;
    data['education'] = education;
    data['previousTypesOfJobs'] = previousTypesOfJobs;
    data['partner'] = partner;
    data['children'] = children;
    data['pet'] = pet;
    data['hobbiesAndInterest'] = hobbiesAndInterest;
    data['cityResidingYears'] = cityResidingYears;
    data['burningDesire'] = burningDesire;
    data['somethingNoOneKnowsAboutMe'] = somethingNoOneKnowsAboutMe;
    data['keyToSuccess'] = keyToSuccess;
    data['residentAddress'] = residentAddress;
    data['permanentAddress'] = permanentAddress;
    data['profileUrl'] = profileUrl;
    data['maritalStatus'] = maritalStatus;
    if (this.businessDetailsResponse != null) {
      data['businessDetailsResponse'] = this.businessDetailsResponse?.toJson();
    }
    if (this.addressRequest != null) {
      data['address'] = this.addressRequest?.toJson();
    }
    return data;
  }
}

class CompanyDetailsRequest {
  String? uuid;
  String? companyName;
  String? companyEstablishment;
  String? companyAddress;
  String? registeredType;
  int? numberOfEmployees;
  String? yearlyTurnover;
  String? companyEmail;
  String? companyWebsite;
  String? companyContact;
  String? businessCategory;
  String? businessDescription;
  String? designation;
  num? yearlyProfit;
  String? gstNumber;
  String? uploadGst;
  String? panNumber;
  String? uploadPan;
  String? aadharNo;
  String? uploadAadhar;
  double? yearOfBusiness;

  CompanyDetailsRequest(
      {this.uuid,
      this.companyName,
      this.companyEstablishment,
      this.companyAddress,
      this.registeredType,
      this.numberOfEmployees,
      this.yearlyTurnover,
      this.companyEmail,
      this.companyWebsite,
      this.companyContact,
      this.businessCategory,
      this.businessDescription,
      this.designation,
      this.yearlyProfit,
      this.gstNumber,
      this.uploadGst,
      this.panNumber,
      this.uploadPan,
      this.aadharNo,
      this.uploadAadhar,
      this.yearOfBusiness,
      });

  CompanyDetailsRequest.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    companyName = json['companyName'];
    companyEstablishment = json['companyEstablishment'];
    companyAddress = json['companyAddress'];
    registeredType = json['registeredType'];
    numberOfEmployees = json['numberOfEmployees'];
    yearlyTurnover = json['yearlyTurnover'];
    companyEmail = json['companyEmail'];
    companyWebsite = json['companyWebsite'];
    companyContact = json['companyContact'];
    businessCategory = json['businessCategory'];
    businessDescription = json['businessDescription'];
    designation = json['designation'];
    yearlyProfit = json['yearlyProfit'];
    gstNumber = json['gstNumber'];
    uploadGst = json['uploadGst'];
    panNumber = json['panNumber'];
    uploadPan = json['uploadPan'];
    aadharNo = json['aadharNo'];
    uploadAadhar = json['uploadAadhar'];
    yearOfBusiness = json['yearOfBusiness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['companyName'] = companyName;
    data['companyEstablishment'] = companyEstablishment;
    data['companyAddress'] = companyAddress;
    data['registeredType'] = registeredType;
    data['numberOfEmployees'] = numberOfEmployees;
    data['yearlyTurnover'] = yearlyTurnover;
    data['companyEmail'] = companyEmail;
    data['companyWebsite'] = companyWebsite;
    data['companyContact'] = companyContact;
    data['businessCategory'] = businessCategory;
    data['businessDescription'] = businessDescription;
    data['designation'] = designation;
    data['yearlyProfit'] = yearlyProfit;
    data['gstNumber'] = gstNumber;
    data['uploadGst'] = uploadGst;
    data['panNumber'] = panNumber;
    data['uploadPan'] = uploadPan;
    data['aadharNo'] = aadharNo;
    data['uploadAadhar'] = uploadAadhar;
    data['yearOfBusiness'] = yearOfBusiness;
    return data;
  }
}

class AddressRequest {
  String? city;
  String? state;
  String? country;
  String? pinCode;

  AddressRequest({
    this.city,
    this.state,
    this.country,
    this.pinCode,
  });

  AddressRequest.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pinCode = json['pinCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['pinCode'] = pinCode;
    return data;
  }
}


CurrentUserData toCurrentUserData({
  required CurrentUserData currentUserData,
  required UpdateProfileRequestModel existingData,
}) {
  // Update user fields
  currentUserData.firstName = existingData.firstName ?? currentUserData.firstName;
  currentUserData.lastName = existingData.lastName ?? currentUserData.lastName;
  currentUserData.dob = existingData.dob ?? currentUserData.dob;
  currentUserData.countryCode = existingData.countryCode ?? currentUserData.countryCode;
  currentUserData.mobileNo = existingData.mobileNo ?? currentUserData.mobileNo;
  currentUserData.uploadDocumentId = existingData.uploadDocumentId ?? currentUserData.uploadDocumentId;
  currentUserData.profileUrl = existingData.profileUrl ?? currentUserData.profileUrl;
  currentUserData.education = existingData.education ?? currentUserData.education;
  currentUserData.previousTypesOfJobs = existingData.previousTypesOfJobs ?? currentUserData.previousTypesOfJobs;
  currentUserData.partner = existingData.partner ?? currentUserData.partner;
  currentUserData.children = existingData.children ?? currentUserData.children;
  currentUserData.pet = existingData.pet ?? currentUserData.pet;
  currentUserData.hobbiesAndInterest = existingData.hobbiesAndInterest ?? currentUserData.hobbiesAndInterest;
  currentUserData.cityResidingYears = existingData.cityResidingYears ?? currentUserData.cityResidingYears;
  currentUserData.burningDesire = existingData.burningDesire ?? currentUserData.burningDesire;
  currentUserData.somethingNoOneKnowsAboutMe = existingData.somethingNoOneKnowsAboutMe ?? currentUserData.somethingNoOneKnowsAboutMe;
  currentUserData.keyToSuccess = existingData.keyToSuccess ?? currentUserData.keyToSuccess;
  currentUserData.permanentAddress = existingData.permanentAddress ?? currentUserData.permanentAddress;
  currentUserData.maritalStatus = existingData.maritalStatus ?? currentUserData.maritalStatus;
  currentUserData.updatedAt = DateTime.now().toIso8601String();

  // Update address
  if (existingData.addressRequest != null) {
    if (currentUserData.currentUserAddress == null) {
      currentUserData.currentUserAddress = CurrentUserAddress();
    }
    currentUserData.currentUserAddress!.city = existingData.addressRequest!.city ?? currentUserData.currentUserAddress!.city;
    currentUserData.currentUserAddress!.state = existingData.addressRequest!.state ?? currentUserData.currentUserAddress!.state;
    currentUserData.currentUserAddress!.country = existingData.addressRequest!.country ?? currentUserData.currentUserAddress!.country;
    currentUserData.currentUserAddress!.pinCode = existingData.addressRequest!.pinCode ?? currentUserData.currentUserAddress!.pinCode;
    currentUserData.currentUserAddress!.updatedAt = DateTime.now().toIso8601String();
  }

  // Update business details
  if (existingData.businessDetailsResponse != null) {
    if (currentUserData.currentUserOrganization == null) {
      currentUserData.currentUserOrganization = CurrentUserOrganization();
    }
    currentUserData.currentUserOrganization!.uuid = existingData.businessDetailsResponse!.uuid ?? currentUserData.currentUserOrganization!.uuid;
    currentUserData.currentUserOrganization!.companyName = existingData.businessDetailsResponse!.companyName ?? currentUserData.currentUserOrganization!.companyName;
    currentUserData.currentUserOrganization!.companyEstablishment = existingData.businessDetailsResponse!.companyEstablishment ?? currentUserData.currentUserOrganization!.companyEstablishment;
    currentUserData.currentUserOrganization!.companyAddress = existingData.businessDetailsResponse!.companyAddress ?? currentUserData.currentUserOrganization!.companyAddress;
    currentUserData.currentUserOrganization!.registeredType = existingData.businessDetailsResponse!.registeredType ?? currentUserData.currentUserOrganization!.registeredType;
    currentUserData.currentUserOrganization!.numberOfEmployees = existingData.businessDetailsResponse!.numberOfEmployees ?? currentUserData.currentUserOrganization!.numberOfEmployees;
    currentUserData.currentUserOrganization!.yearlyTurnover = existingData.businessDetailsResponse!.yearlyTurnover ?? currentUserData.currentUserOrganization!.yearlyTurnover;
    currentUserData.currentUserOrganization!.companyEmail = existingData.businessDetailsResponse!.companyEmail ?? currentUserData.currentUserOrganization!.companyEmail;
    currentUserData.currentUserOrganization!.companyWebsite = existingData.businessDetailsResponse!.companyWebsite ?? currentUserData.currentUserOrganization!.companyWebsite;
    currentUserData.currentUserOrganization!.companyContact = existingData.businessDetailsResponse!.companyContact ?? currentUserData.currentUserOrganization!.companyContact;
    currentUserData.currentUserOrganization!.businessCategory = existingData.businessDetailsResponse!.businessCategory ?? currentUserData.currentUserOrganization!.businessCategory;
    currentUserData.currentUserOrganization!.businessDescription = existingData.businessDetailsResponse!.businessDescription ?? currentUserData.currentUserOrganization!.businessDescription;
    currentUserData.currentUserOrganization!.designation = existingData.businessDetailsResponse!.designation ?? currentUserData.currentUserOrganization!.designation;
    currentUserData.currentUserOrganization!.yearlyProfit = existingData.businessDetailsResponse!.yearlyProfit ?? currentUserData.currentUserOrganization!.yearlyProfit;
    currentUserData.currentUserOrganization!.gstNumber = existingData.businessDetailsResponse!.gstNumber ?? currentUserData.currentUserOrganization!.gstNumber;
    currentUserData.currentUserOrganization!.uploadGst = existingData.businessDetailsResponse!.uploadGst ?? currentUserData.currentUserOrganization!.uploadGst;
    currentUserData.currentUserOrganization!.panNumber = existingData.businessDetailsResponse!.panNumber ?? currentUserData.currentUserOrganization!.panNumber;
    currentUserData.currentUserOrganization!.uploadPan = existingData.businessDetailsResponse!.uploadPan ?? currentUserData.currentUserOrganization!.uploadPan;
    currentUserData.currentUserOrganization!.aadharNo = existingData.businessDetailsResponse!.aadharNo ?? currentUserData.currentUserOrganization!.aadharNo;
    currentUserData.currentUserOrganization!.uploadAadhar = existingData.businessDetailsResponse!.uploadAadhar ?? currentUserData.currentUserOrganization!.uploadAadhar;
  }

  return currentUserData;
}

