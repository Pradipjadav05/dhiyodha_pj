class CurrentUserResponseModel {
  String? timestamp;
  String? status;
  String? message;
  CurrentUserData? currentUserData;

  CurrentUserResponseModel(
      {this.timestamp, this.status, this.message, this.currentUserData});

  CurrentUserResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    currentUserData = json['data'] != null
        ? new CurrentUserData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.currentUserData != null) {
      data['data'] = this.currentUserData!.toJson();
    }
    return data;
  }
}

class CurrentUserData {
  String? uuid;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? dob;
  String? countryCode;
  String? uploadDocumentId;
  String? profileUrl;
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
  String? permanentAddress;
  CurrentUserAddress? currentUserAddress;
  String? maritalStatus;
  List<CurrentUserRoles>? currentUserRoles;
  CurrentUserOrganization? currentUserOrganization;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<CurrentUserGroup>? userGroups;

  CurrentUserData(
      {this.uuid,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNo,
      this.dob,
      this.countryCode,
      this.uploadDocumentId,
      this.profileUrl,
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
      this.permanentAddress,
      this.currentUserAddress,
      this.maritalStatus,
      this.currentUserRoles,
      this.currentUserOrganization,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userGroups});

  CurrentUserData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    dob = json['dob'];
    countryCode = json['countryCode'];
    uploadDocumentId = json['uploadDocumentId'];
    profileUrl = json['profileUrl'];
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
    permanentAddress = json['permanentAddress'];
    currentUserAddress = json['address'] != null
        ? new CurrentUserAddress.fromJson(json['address'])
        : null;
    maritalStatus = json['maritalStatus'];
    if (json['roles'] != null) {
      currentUserRoles = <CurrentUserRoles>[];
      json['roles'].forEach((v) {
        currentUserRoles!.add(new CurrentUserRoles.fromJson(v));
      });
    }
    currentUserOrganization = json['businessDetails'] != null
        ? new CurrentUserOrganization.fromJson(json['businessDetails'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['userGroups'] != null) {
      userGroups = <CurrentUserGroup>[];
      json['userGroups'].forEach((v) {
        userGroups!.add(new CurrentUserGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['dob'] = this.dob;
    data['countryCode'] = this.countryCode;
    data['education'] = this.education;
    data['previousTypesOfJobs'] = this.previousTypesOfJobs;
    data['partner'] = this.partner;
    data['children'] = this.children;
    data['pet'] = this.pet;
    data['hobbiesAndInterest'] = this.hobbiesAndInterest;
    data['cityResidingYears'] = this.cityResidingYears;
    data['burningDesire'] = this.burningDesire;
    data['somethingNoOneKnowsAboutMe'] = this.somethingNoOneKnowsAboutMe;
    data['keyToSuccess'] = this.keyToSuccess;
    data['uploadDocumentId'] = this.uploadDocumentId;
    data['profileUrl'] = this.profileUrl;
    data['permanentAddress'] = this.permanentAddress;
    if (this.currentUserAddress != null) {
      data['address'] = this.currentUserAddress!.toJson();
    }
    data['maritalStatus'] = this.maritalStatus;
    if (this.currentUserRoles != null) {
      data['roles'] = this.currentUserRoles!.map((v) => v.toJson()).toList();
    }
    if (this.currentUserOrganization != null) {
      data['businessDetails'] = this.currentUserOrganization!.toJson();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.userGroups != null) {
      data['userGroups'] = this.userGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentUserAddress {
  String? uuid;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? createdAt;
  String? updatedAt;

  CurrentUserAddress(
      {this.uuid,
      this.city,
      this.state,
      this.country,
      this.pinCode,
      this.createdAt,
      this.updatedAt});

  CurrentUserAddress.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pinCode = json['pinCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pinCode'] = this.pinCode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CurrentUserRoles {
  String? uuid;
  String? roleName;
  String? createdAt;
  String? createdBy;

  CurrentUserRoles({this.uuid, this.roleName, this.createdAt, this.createdBy});

  CurrentUserRoles.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    roleName = json['roleName'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['roleName'] = this.roleName;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class CurrentUserOrganization {
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

  CurrentUserOrganization(
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

  CurrentUserOrganization.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    companyName = json['companyName'];
    companyEstablishment = json['companyEstablishment'];
    companyAddress = json['companyAddress'];
    registeredType = json['registeredType'];
    numberOfEmployees = json['numberOfEmployees'];
    yearlyTurnover = json['yearlyTurnover'];
    companyEmail = json['companyEmail'];
    if (json['companyWebsite'] != null) {
      companyWebsite = json['companyWebsite'];
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['companyName'] = this.companyName;
    data['companyEstablishment'] = this.companyEstablishment;
    data['companyAddress'] = this.companyAddress;
    data['registeredType'] = this.registeredType;
    data['numberOfEmployees'] = this.numberOfEmployees;
    data['yearlyTurnover'] = this.yearlyTurnover;
    data['companyEmail'] = this.companyEmail;
    if (this.companyWebsite != null) {
      data['companyWebsite'] = this.companyWebsite;
    }
    data['companyContact'] = this.companyContact;
    data['businessCategory'] = this.businessCategory;
    data['businessDescription'] = this.businessDescription;
    data['designation'] = this.designation;
    data['yearlyProfit'] = this.yearlyProfit;
    data['gstNumber'] = this.gstNumber;
    data['uploadGst'] = this.uploadGst;
    data['panNumber'] = this.panNumber;
    data['uploadPan'] = this.uploadPan;
    data['aadharNo'] = this.aadharNo;
    data['uploadAadhar'] = this.uploadAadhar;
    data['yearOfBusiness'] = this.yearOfBusiness;
    return data;
  }
}

class CurrentUserGroup {
  String? uuid;
  String? groupName;
  String? description;
  int? groupLimit;
  String? groupStatus;
  String? meetingDay;
  String? country;
  String? state;
  String? city;

  CurrentUserGroup({
    this.uuid,
    this.groupName,
    this.description,
    this.groupLimit,
    this.groupStatus,
    this.meetingDay,
    this.country,
    this.state,
    this.city,
  });

  CurrentUserGroup.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    groupName = json['groupName'];
    description = json['description'];
    groupLimit = json['groupLimit'];
    groupStatus = json['groupStatus'];
    meetingDay = json['meetingDay'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['groupName'] = this.groupName;
    data['description'] = this.description;
    data['groupLimit'] = this.groupLimit;
    data['groupStatus'] = this.groupStatus;
    data['meetingDay'] = this.meetingDay;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    return data;
  }
}
