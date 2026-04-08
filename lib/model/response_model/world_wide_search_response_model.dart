class WorldWideSearchResponseModel {
  String? timestamp;
  String? status;
  String? message;
  List<WorldWideMembers>? worldWideMember;

  WorldWideSearchResponseModel(
      {this.timestamp, this.status, this.message, this.worldWideMember});

  WorldWideSearchResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      worldWideMember = <WorldWideMembers>[];
      json['data'].forEach((v) {
        worldWideMember!.add(new WorldWideMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.worldWideMember != null) {
      data['data'] = this.worldWideMember!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorldWideMembers {
  String? id;
  String? uuid;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;
  String? firstName;
  String? lastName;
  String? email;
  String? dob;
  String? countryCode;
  String? profileUrl;
  String? mobileNo;
  String? password;
  String? education;
  String? maritalStatus;
  Organization? organization;
  Address? address;
  List<Roles>? roles;
  List<UserGroup>? userGroups;
  String? status;
  String? createdBy;
  String? fatherOrHusbandName;
  String? fatherOrHusbandProfession;
  String? cast;
  String? university;
  String? aadhaarNumber;
  String? panNumber;
  String? uploadAadhaar;
  String? uploadPan;
  String? uploadDocumentId;
  int? children;
  String? pet;
  String? hobbiesAndInterest;
  int? cityResidingYears;
  String? burningDesire;
  String? keyToSuccess;

  WorldWideMembers(
      {this.id,
      this.uuid,
      this.createdAt,
      this.updatedAt,
      this.updatedBy,
      this.firstName,
      this.lastName,
      this.email,
      this.dob,
      this.countryCode,
      this.profileUrl,
      this.mobileNo,
      this.password,
      this.education,
      this.maritalStatus,
      this.organization,
      this.address,
      this.roles,
      this.status,
      this.createdBy,
      this.fatherOrHusbandName,
      this.fatherOrHusbandProfession,
      this.cast,
      this.university,
      this.aadhaarNumber,
      this.panNumber,
      this.uploadAadhaar,
      this.uploadPan,
      this.uploadDocumentId,
      this.children,
      this.pet,
      this.hobbiesAndInterest,
      this.cityResidingYears,
      this.burningDesire,
      this.userGroups,
      this.keyToSuccess});

  WorldWideMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    dob = json['dob'];
    countryCode = json['countryCode'];
    profileUrl = json['profileUrl'];
    mobileNo = json['mobileNo'];
    password = json['password'];
    education = json['education'];
    maritalStatus = json['maritalStatus'];
    organization = json['businessDetails'] != null
        ? new Organization.fromJson(json['businessDetails'])
        : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    status = json['status'];
    createdBy = json['createdBy'];
    fatherOrHusbandName = json['fatherOrHusbandName'];
    fatherOrHusbandProfession = json['fatherOrHusbandProfession'];
    cast = json['cast'];
    university = json['university'];
    aadhaarNumber = json['aadhaarNumber'];
    panNumber = json['panNumber'];
    uploadAadhaar = json['uploadAadhaar'];
    uploadPan = json['uploadPan'];
    uploadDocumentId = json['uploadDocumentId'];
    children = json['children'];
    pet = json['pet'];
    hobbiesAndInterest = json['hobbiesAndInterest'];
    cityResidingYears = json['cityResidingYears'];
    burningDesire = json['burningDesire'];
    keyToSuccess = json['keyToSuccess'];
    if (json['groupName'] != null) {
      userGroups = [];
      userGroups!.add(UserGroup(groupName: json['groupName']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['countryCode'] = this.countryCode;
    data['profileUrl'] = this.profileUrl;
    data['mobileNo'] = this.mobileNo;
    data['password'] = this.password;
    data['education'] = this.education;
    data['maritalStatus'] = this.maritalStatus;
    if (this.organization != null) {
      data['businessDetails'] = this.organization!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['fatherOrHusbandName'] = this.fatherOrHusbandName;
    data['fatherOrHusbandProfession'] = this.fatherOrHusbandProfession;
    data['cast'] = this.cast;
    data['university'] = this.university;
    data['aadhaarNumber'] = this.aadhaarNumber;
    data['panNumber'] = this.panNumber;
    data['uploadAadhaar'] = this.uploadAadhaar;
    data['uploadPan'] = this.uploadPan;
    data['uploadDocumentId'] = this.uploadDocumentId;
    data['children'] = this.children;
    data['pet'] = this.pet;
    data['hobbiesAndInterest'] = this.hobbiesAndInterest;
    data['cityResidingYears'] = this.cityResidingYears;
    data['burningDesire'] = this.burningDesire;
    data['keyToSuccess'] = this.keyToSuccess;
    if (this.userGroups != null) {
      data['userGroups'] = this.userGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Organization {
  String? id;
  String? uuid;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? businessCategory;
  String? companyName;
  int? establishedYear;
  String? companyRegistration;
  String? numberOfStaff;
  String? gstNumber;
  String? officeNumber;
  String? officeEmail;

  Organization(
      {this.id,
      this.uuid,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.businessCategory,
      this.companyName,
      this.establishedYear,
      this.companyRegistration,
      this.numberOfStaff,
      this.gstNumber,
      this.officeNumber,
      this.officeEmail});

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    businessCategory = json['businessCategory'];
    companyName = json['companyName'];
    establishedYear = json['establishedYear'];
    companyRegistration = json['companyRegistration'];
    numberOfStaff = json['numberOfStaff'];
    gstNumber = json['gstNumber'];
    officeNumber = json['officeNumber'];
    officeEmail = json['officeEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['updatedAt'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    data['businessCategory'] = this.businessCategory;
    data['companyName'] = this.companyName;
    data['establishedYear'] = this.establishedYear;
    data['companyRegistration'] = this.companyRegistration;
    data['numberOfStaff'] = this.numberOfStaff;
    data['gstNumber'] = this.gstNumber;
    data['officeNumber'] = this.officeNumber;
    data['officeEmail'] = this.officeEmail;
    return data;
  }
}

class Address {
  String? id;
  String? uuid;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? city;
  String? state;
  String? pinCode;
  String? country;

  Address(
      {this.id,
      this.uuid,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.city,
      this.state,
      this.pinCode,
      this.country});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pinCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['updatedAt'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pinCode'] = this.pinCode;
    data['country'] = this.country;
    return data;
  }
}

class Roles {
  String? id;
  String? uuid;
  String? createdAt;
  String? createdBy;
  String? roleName;

  Roles({this.id, this.uuid, this.createdAt, this.createdBy, this.roleName});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['roleName'] = this.roleName;
    return data;
  }
}

class UserGroup {
  String? uuid;
  String? groupName;
  String? description;
  int? groupLimit;
  String? city;
  String? state;
  String? country;
  String? groupStatus;

  UserGroup({
    this.uuid,
    this.groupName,
    this.description,
    this.groupLimit,
    this.city,
    this.state,
    this.country,
    this.groupStatus,
  });

  UserGroup.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    groupName = json['groupName'];
    description = json['description'];
    groupLimit = json['groupLimit'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    groupStatus = json['groupStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uuid'] = uuid;
    data['groupName'] = groupName;
    data['description'] = description;
    data['groupLimit'] = groupLimit;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['groupStatus'] = groupStatus;
    return data;
  }
}
