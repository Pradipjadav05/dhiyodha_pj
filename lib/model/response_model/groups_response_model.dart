class GroupsResponseModel {
  String? timestamp;
  String? status;
  String? message;
  GroupData? groupData;

  GroupsResponseModel(
      {this.timestamp, this.status, this.message, this.groupData});

  GroupsResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    groupData =
        json['data'] != null ? new GroupData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.groupData != null) {
      data['data'] = this.groupData!.toJson();
    }
    return data;
  }
}

class GroupData {
  List<GroupChildData>? groupChildData;
  int? page;
  int? size;
  int? total;

  GroupData({this.groupChildData, this.page, this.size, this.total});

  GroupData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      groupChildData = <GroupChildData>[];
      json['data'].forEach((v) {
        groupChildData!.add(new GroupChildData.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groupChildData != null) {
      data['data'] = this.groupChildData!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class GroupChildData {
  String? uuid;
  String? groupName;
  String? description;
  int? groupLimit;
  String? groupStatus;
  List<Users>? users;
  String? groupAdmin;
  String? meetingDay;
  Region? region;
  String? createdAt;
  String? createdBy;

  GroupChildData(
      {this.uuid,
      this.groupName,
      this.description,
      this.groupLimit,
      this.groupStatus,
      this.users,
      this.groupAdmin,
      this.meetingDay,
      this.region,
      this.createdAt,
      this.createdBy});

  GroupChildData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    groupName = json['groupName'];
    description = json['description'];
    groupLimit = json['groupLimit'];
    groupStatus = json['groupStatus'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    groupAdmin = json['groupAdmin'];
    meetingDay = json['meetingDay'];
    region =
        json['region'] != null ? new Region.fromJson(json['region']) : null;
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['groupName'] = this.groupName;
    data['description'] = this.description;
    data['groupLimit'] = this.groupLimit;
    data['groupStatus'] = this.groupStatus;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['groupAdmin'] = this.groupAdmin;
    data['meetingDay'] = this.meetingDay;
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class Users {
  String? uuid;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? dob;
  String? countryCode;
  String? profileUrl;
  String? education;
  Address? address;
  String? maritalStatus;
  List<Roles>? roles;
  Organization? organization;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? uploadDocumentId;
  int? children;
  String? pet;
  String? hobbiesAndInterest;
  int? cityResidingYears;
  String? burningDesire;
  String? keyToSuccess;

  Users(
      {this.uuid,
      this.firstName,
      this.lastName,
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
      this.uploadDocumentId,
      this.children,
      this.pet,
      this.hobbiesAndInterest,
      this.cityResidingYears,
      this.burningDesire,
      this.keyToSuccess});

  Users.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
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
    children = json['children'];
    pet = json['pet'];
    hobbiesAndInterest = json['hobbiesAndInterest'];
    cityResidingYears = json['cityResidingYears'];
    burningDesire = json['burningDesire'];
    keyToSuccess = json['keyToSuccess'];
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
      data['organization'] = this.organization!.toJson();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['uploadDocumentId'] = this.uploadDocumentId;
    data['children'] = this.children;
    data['pet'] = this.pet;
    data['hobbiesAndInterest'] = this.hobbiesAndInterest;
    data['cityResidingYears'] = this.cityResidingYears;
    data['burningDesire'] = this.burningDesire;
    data['keyToSuccess'] = this.keyToSuccess;
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
  String? country;

  Address(
      {this.uuid,
      this.city,
      this.state,
      this.pinCode,
      this.createdAt,
      this.updatedAt,
      this.country});

  Address.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pinCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pinCode'] = this.pinCode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['country'] = this.country;
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
  String? businessCategory;
  String? companyName;
  String? companyRegistration;
  int? establishedYear;
  String? numberOfStaff;
  String? gstNumber;
  String? officeNumber;
  String? officeEmail;
  String? createdAt;
  String? createdBy;

  Organization(
      {this.uuid,
      this.businessCategory,
      this.companyName,
      this.companyRegistration,
      this.establishedYear,
      this.numberOfStaff,
      this.gstNumber,
      this.officeNumber,
      this.officeEmail,
      this.createdAt,
      this.createdBy});

  Organization.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    businessCategory = json['businessCategory'];
    companyName = json['companyName'];
    companyRegistration = json['companyRegistration'];
    establishedYear = json['establishedYear'];
    numberOfStaff = json['numberOfStaff'];
    gstNumber = json['gstNumber'];
    officeNumber = json['officeNumber'];
    officeEmail = json['officeEmail'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['businessCategory'] = this.businessCategory;
    data['companyName'] = this.companyName;
    data['companyRegistration'] = this.companyRegistration;
    data['establishedYear'] = this.establishedYear;
    data['numberOfStaff'] = this.numberOfStaff;
    data['gstNumber'] = this.gstNumber;
    data['officeNumber'] = this.officeNumber;
    data['officeEmail'] = this.officeEmail;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class Region {
  double? latitude;
  double? longitude;

  Region({this.latitude, this.longitude});

  Region.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
