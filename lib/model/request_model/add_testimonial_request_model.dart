class AddTestimonialRequestModel {
  String? review;
  String? type;
  String? reviewerUuid;

  AddTestimonialRequestModel(
      {
      this.review,
      this.type,
      this.reviewerUuid});

  AddTestimonialRequestModel.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    type = json['type'];
    reviewerUuid = json['reviewerUuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review'] = this.review;
    data['type'] = this.type;
    data['reviewerUuid'] = this.reviewerUuid;
    return data;
  }
}

class Reviewer {
  String? firstName;
  String? lastName;
  String? dob;
  String? countryCode;
  String? mobileNo;
  String? uploadDocumentId;
  String? education;
  int? children;
  String? pet;
  String? hobbiesAndInterest;
  int? cityResidingYears;
  String? burningDesire;
  String? somethingNoOneKnowsAboutMe;
  String? keyToSuccess;
  String? residentAddress;
  String? permanentAddress;
  String? maritalStatus;
  CompanyDetailsRequest? companyDetailsRequest;
  AddressRequest? addressRequest;

  Reviewer({
    this.firstName,
    this.lastName,
    this.dob,
    this.countryCode,
    this.mobileNo,
    this.uploadDocumentId,
    this.education,
    this.children,
    this.pet,
    this.hobbiesAndInterest,
    this.cityResidingYears,
    this.burningDesire,
    this.somethingNoOneKnowsAboutMe,
    this.keyToSuccess,
    this.maritalStatus,
    this.companyDetailsRequest,
    this.addressRequest,
  });

  Reviewer.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'];
    countryCode = json['countryCode'];
    mobileNo = json['mobileNo'];
    uploadDocumentId = json['uploadDocumentId'];
    education = json['education'];
    children = json['children'];
    pet = json['pet'];
    hobbiesAndInterest = json['hobbiesAndInterest'];
    cityResidingYears = json['cityResidingYears'];
    burningDesire = json['burningDesire'];
    somethingNoOneKnowsAboutMe = json['somethingNoOneKnowsAboutMe'];
    keyToSuccess = json['keyToSuccess'];
    maritalStatus = json['maritalStatus'];
    companyDetailsRequest = json['businessDetailsResponse'] != null
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
    data['children'] = children;
    data['pet'] = pet;
    data['hobbiesAndInterest'] = hobbiesAndInterest;
    data['cityResidingYears'] = cityResidingYears;
    data['burningDesire'] = burningDesire;
    data['somethingNoOneKnowsAboutMe'] = somethingNoOneKnowsAboutMe;
    data['keyToSuccess'] = keyToSuccess;
    data['maritalStatus'] = maritalStatus;
    if (this.companyDetailsRequest != null) {
      data['businessDetailsResponse'] = this.companyDetailsRequest?.toJson();
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
  String? companyContact;
  String? businessCategory;
  String? businessDescription;
  num? yearlyProfit;
  String? gstNumber;
  String? uploadGst;
  String? panNumber;
  String? uploadPan;

  CompanyDetailsRequest(
      {this.uuid,
      this.companyName,
      this.companyEstablishment,
      this.companyAddress,
      this.registeredType,
      this.numberOfEmployees,
      this.yearlyTurnover,
      this.companyEmail,
      this.companyContact,
      this.businessCategory,
      this.businessDescription,
      this.yearlyProfit,
      this.gstNumber,
      this.uploadGst,
      this.panNumber,
      this.uploadPan});

  CompanyDetailsRequest.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    companyName = json['companyName'];
    companyEstablishment = json['companyEstablishment'];
    companyAddress = json['companyAddress'];
    registeredType = json['registeredType'];
    numberOfEmployees = json['numberOfEmployees'];
    yearlyTurnover = json['yearlyTurnover'];
    companyEmail = json['companyEmail'];
    companyContact = json['companyContact'];
    businessCategory = json['businessCategory'];
    businessDescription = json['businessDescription'];
    yearlyProfit = json['yearlyProfit'];
    gstNumber = json['gstNumber'];
    uploadGst = json['uploadGst'];
    panNumber = json['panNumber'];
    uploadPan = json['uploadPan'];
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
    data['companyContact'] = companyContact;
    data['businessCategory'] = businessCategory;
    data['businessDescription'] = businessDescription;
    data['yearlyProfit'] = yearlyProfit;
    data['gstNumber'] = gstNumber;
    data['uploadGst'] = uploadGst;
    data['panNumber'] = panNumber;
    data['uploadPan'] = uploadPan;
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
