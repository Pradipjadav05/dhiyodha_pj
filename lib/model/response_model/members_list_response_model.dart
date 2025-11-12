class MembersListResponseModel {
  String? timestamp;
  String? status;
  String? message;
  MembersData? membersData;

  MembersListResponseModel(
      {this.timestamp, this.status, this.message, this.membersData});

  MembersListResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    membersData =
        json['data'] != null ? new MembersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.membersData != null) {
      data['data'] = this.membersData!.toJson();
    }
    return data;
  }
}

class MembersData {
  List<MembersChildData>? membersChildData;
  int? page;
  int? size;
  int? total;
  int? currentCount;

  MembersData({this.membersChildData, this.page, this.size, this.total});

  MembersData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      membersChildData = <MembersChildData>[];
      json['data'].forEach((v) {
        membersChildData!.add(new MembersChildData.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    total = json['total'];
    currentCount = json['currentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.membersChildData != null) {
      data['data'] = this.membersChildData!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['size'] = this.size;
    data['total'] = this.total;
    data['currentCount'] = this.currentCount;
    return data;
  }
}

class MembersChildData {
  String? uuid;
  String? firstName;
  String? lastName;
  String? fatherOrHusbandName;
  String? fatherOrHusbandProfession;
  String? email;
  String? mobileNo;
  String? cast;
  String? university;
  String? dob;
  String? profileUrl;
  String? education;
  String? previousTypesOfJobs;
  String? partner;
  String? permanentAddress;
  String? aadhaarNumber;
  String? panNumber;
  String? uploadAadhaar;
  String? uploadPan;
  String? countryCode;
  Address? address;
  String? maritalStatus;
  List<Roles>? roles;
  Organization? organization;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? uploadDocumentId;

  MembersChildData(
      {this.uuid,
      this.firstName,
      this.lastName,
      this.fatherOrHusbandName,
      this.fatherOrHusbandProfession,
      this.cast,
      this.university,
      this.aadhaarNumber,
      this.panNumber,
      this.uploadAadhaar,
      this.uploadPan,
      this.email,
      this.mobileNo,
      this.dob,
      this.countryCode,
      this.profileUrl,
      this.education,
      this.address,
      this.maritalStatus,
      this.roles,
      this.organization,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.uploadDocumentId});

  MembersChildData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fatherOrHusbandName = json['fatherOrHusbandName'];
    fatherOrHusbandProfession = json['fatherOrHusbandProfession'];
    cast = json['cast'];
    university = json['university'];
    aadhaarNumber = json['aadhaarNumber'];
    panNumber = json['panNumber'];
    uploadAadhaar = json['uploadAadhaar'];
    uploadPan = json['uploadPan'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    dob = json['dob'];
    countryCode = json['countryCode'];
    profileUrl = json['profileUrl'];
    education = json['education'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    maritalStatus = json['maritalStatus'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    organization = json['businessDetails'] != null
        ? new Organization.fromJson(json['businessDetails'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    uploadDocumentId = json['uploadDocumentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fatherOrHusbandName'] = this.fatherOrHusbandName;
    data['fatherOrHusbandProfession'] = this.fatherOrHusbandProfession;
    data['cast'] = this.cast;
    data['university'] = this.university;
    data['aadhaarNumber'] = this.aadhaarNumber;
    data['panNumber'] = this.panNumber;
    data['uploadAadhaar'] = this.uploadAadhaar;
    data['uploadPan'] = this.uploadPan;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['dob'] = this.dob;
    data['countryCode'] = this.countryCode;
    data['profileUrl'] = this.profileUrl;
    data['education'] = this.education;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['maritalStatus'] = this.maritalStatus;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    if (this.organization != null) {
      data['businessDetails'] = this.organization!.toJson();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['uploadDocumentId'] = this.uploadDocumentId;
    return data;
  }
}

class Address {
  String? uuid;
  String? city;
  String? state;
  String? pinCode;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.uuid,
      this.city,
      this.state,
      this.pinCode,
      this.createdAt,
      this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pinCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pinCode'] = this.pinCode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Roles {
  String? uuid;
  String? roleName;
  String? createdAt;
  String? createdBy;

  Roles({this.uuid, this.roleName, this.createdAt, this.createdBy});

  Roles.fromJson(Map<String, dynamic> json) {
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

class Organization {
  String? uuid;
  String? companyName;
  String? companyEstablishment;
  String? companyAddress;
  String? registeredType;
  int? numberOfEmployees;
  String? yearlyTurnover;
  String? companyEmail;
  String? companyContact;
  String? companyWebsite;
  String? businessCategory;
  String? businessDescription;
  String? designation;
  num? yearlyProfit;
  String? gstNumber;
  String? uploadGst;
  String? panNumber;
  String? uploadPan;

  Organization(
      {this.uuid,
      this.companyName,
      this.companyEstablishment,
      this.companyAddress,
      this.registeredType,
      this.numberOfEmployees,
      this.yearlyTurnover,
      this.companyEmail,
      this.companyContact,
      this.companyWebsite,
      this.businessCategory,
      this.businessDescription,
      this.designation,
      this.yearlyProfit,
      this.gstNumber,
      this.uploadGst,
      this.panNumber,
      this.uploadPan});

  Organization.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    companyName = json['companyName'];
    companyEstablishment = json['companyEstablishment'];
    companyAddress = json['companyAddress'];
    registeredType = json['registeredType'];
    numberOfEmployees = json['numberOfEmployees'];
    yearlyTurnover = json['yearlyTurnover'];
    companyEmail = json['companyEmail'];
    companyContact = json['companyContact'];
    companyWebsite = json['companyWebsite'];
    businessCategory = json['businessCategory'];
    businessDescription = json['businessDescription'];
    designation = json['designation'];
    yearlyProfit = json['yearlyProfit'];
    gstNumber = json['gstNumber'];
    uploadGst = json['uploadGst'];
    panNumber = json['panNumber'];
    uploadPan = json['uploadPan'];
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
    data['companyContact'] = this.companyContact;
    data['companyWebsite'] = this.companyWebsite;
    data['businessCategory'] = this.businessCategory;
    data['businessDescription'] = this.businessDescription;
    data['designation'] = this.designation;
    data['yearlyProfit'] = this.yearlyProfit;
    data['gstNumber'] = this.gstNumber;
    data['uploadGst'] = this.uploadGst;
    data['panNumber'] = this.panNumber;
    data['uploadPan'] = this.uploadPan;
    return data;
  }
}
