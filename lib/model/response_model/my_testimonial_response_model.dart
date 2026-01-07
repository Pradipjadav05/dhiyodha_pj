import 'package:dhiyodha/model/response_model/members_list_response_model.dart';

class MyTestimonialResponseModel {
  String? timestamp;
  String? status;
  String? message;
  MyTestimonialData? myTestimonialData;

  MyTestimonialResponseModel(
      {this.timestamp, this.status, this.message, this.myTestimonialData});

  MyTestimonialResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    myTestimonialData = json['data'] != null
        ? new MyTestimonialData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.myTestimonialData != null) {
      data['data'] = this.myTestimonialData!.toJson();
    }
    return data;
  }
}

class MyTestimonialData {
  List<MyTestimonialChildData>? myTestimonialChildData;
  int? page;
  int? size;
  int? total;

  MyTestimonialData(
      {this.myTestimonialChildData, this.page, this.size, this.total});

  MyTestimonialData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      myTestimonialChildData = <MyTestimonialChildData>[];
      json['data'].forEach((v) {
        myTestimonialChildData!.add(new MyTestimonialChildData.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myTestimonialChildData != null) {
      data['data'] =
          this.myTestimonialChildData!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class MyTestimonialChildData {
  String? id;
  String? uuid;
  String? review;
  String? type;
  Reviewer? reviewer;
  String? reviewerFirstName;
  String? reviewerLastName;
  String? reviewerPofileUrl;

  MyTestimonialChildData(
      {this.uuid,
      this.id,
      this.review,
      this.type,
      this.reviewer,
      this.reviewerFirstName,
      this.reviewerLastName,
      this.reviewerPofileUrl});

  MyTestimonialChildData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    review = json['review'];
    type = json['type'];
    reviewer = json['reviewer'] != null
        ? new Reviewer.fromJson(json['reviewer'])
        : null;
    reviewerFirstName = json['reviewerFirstName'];
    reviewerLastName = json['reviewerLastName'];
    reviewerPofileUrl = json['reviewerPofileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['review'] = this.review;
    data['type'] = this.type;
    if (this.reviewer != null) {
      data['reviewer'] = this.reviewer!.toJson();
    }
    data['reviewerFirstName'] = this.reviewerFirstName;
    data['reviewerLastName'] = this.reviewerLastName;
    data['reviewerPofileUrl'] = this.reviewerPofileUrl;
    return data;
  }
}

class TestimonialChildData {
  String? uuid;
  String? review;
  String? type;
  Reviewer? reviewer;
  String? reviewerFirstName;
  String? reviewerLastName;
  String? reviewerPofileUrl;

  TestimonialChildData(
      {this.uuid,
      this.review,
      this.type,
      this.reviewer,
      this.reviewerFirstName,
      this.reviewerLastName,
      this.reviewerPofileUrl});

  TestimonialChildData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    review = json['review'];
    type = json['type'];
    reviewer = json['reviewer'] != null
        ? new Reviewer.fromJson(json['reviewer'])
        : null;
    reviewerFirstName = json['reviewerFirstName'];
    reviewerLastName = json['reviewerLastName'];
    reviewerPofileUrl = json['reviewerPofileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['review'] = this.review;
    data['type'] = this.type;
    if (this.reviewer != null) {
      data['reviewer'] = this.reviewer!.toJson();
    }
    data['reviewerFirstName'] = this.reviewerFirstName;
    data['reviewerLastName'] = this.reviewerLastName;
    data['reviewerPofileUrl'] = this.reviewerPofileUrl;
    return data;
  }
}

class Reviewer {
  String? id;
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
  int? children;
  String? pet;
  String? hobbiesAndInterest;
  int? cityResidingYears;
  String? burningDesire;
  String? keyToSuccess;
  Address? address;
  String? maritalStatus;
  List<Roles>? roles;
  Organization? organization;
  String? status;
  String? createdAt;
  String? updatedAt;

  Reviewer(
      {this.id,
      this.uuid,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNo,
      this.dob,
      this.countryCode,
      this.uploadDocumentId,
      this.profileUrl,
      this.education,
      this.children,
      this.pet,
      this.hobbiesAndInterest,
      this.cityResidingYears,
      this.burningDesire,
      this.keyToSuccess,
      this.address,
      this.maritalStatus,
      this.roles,
      this.organization,
      this.status,
      this.createdAt,
      this.updatedAt});

  Reviewer.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    dob = json['dob'];
    countryCode = json['countryCode'];
    uploadDocumentId = json['uploadDocumentId'];
    profileUrl = json['profileUrl'];
    education = json['education'];
    children = json['children'];
    pet = json['pet'];
    hobbiesAndInterest = json['hobbiesAndInterest'];
    cityResidingYears = json['cityResidingYears'];
    burningDesire = json['burningDesire'];
    keyToSuccess = json['keyToSuccess'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['dob'] = this.dob;
    data['countryCode'] = this.countryCode;
    data['uploadDocumentId'] = this.uploadDocumentId;
    data['profileUrl'] = this.profileUrl;
    data['education'] = this.education;
    data['children'] = this.children;
    data['pet'] = this.pet;
    data['hobbiesAndInterest'] = this.hobbiesAndInterest;
    data['cityResidingYears'] = this.cityResidingYears;
    data['burningDesire'] = this.burningDesire;
    data['keyToSuccess'] = this.keyToSuccess;
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
    return data;
  }
}
