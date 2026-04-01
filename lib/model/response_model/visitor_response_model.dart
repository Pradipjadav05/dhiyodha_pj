import 'package:dhiyodha/utils/resource/app_media_assets.dart';

class VisitorResponseModel {
  String? timestamp;
  String? status;
  String? message;
  VisitorData? visitorData;

  VisitorResponseModel(
      {this.timestamp, this.status, this.message, this.visitorData});

  VisitorResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    visitorData =
        json['data'] != null ? new VisitorData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.visitorData != null) {
      data['data'] = this.visitorData!.toJson();
    }
    return data;
  }
}

class VisitorData {
  List<VisitorChildData>? visitorChildData;
  int? page;
  int? size;
  int? total;

  VisitorData({this.visitorChildData, this.page, this.size, this.total});

  VisitorData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      visitorChildData = <VisitorChildData>[];
      json['data'].forEach((v) {
        visitorChildData!.add(new VisitorChildData.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.visitorChildData != null) {
      data['data'] = this.visitorChildData!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class VisitorChildData {
  String? uuId;
  String? country;
  String? state;
  String? city;
  String? chapter;
  String? date;
  String? businessCategory;
  String? name;
  String? contactNumber;
  String? companyName;
  String? addedBy;
  String? groupName;
  String? title;
  String? meetingDate;
  String? email;
  String? meetingCode;
  String? profileUrl;

  VisitorChildData(
      {this.uuId,
      this.country,
      this.state,
      this.city,
      this.chapter,
      this.date,
      this.businessCategory,
      this.name,
      this.contactNumber,
      this.companyName,
      this.addedBy,
      this.groupName,
      this.title,
      this.meetingDate,
      this.email,
      this.profileUrl,
      this.meetingCode});

  VisitorChildData.fromJson(Map<String, dynamic> json) {
    uuId = json['uuId'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    chapter = json['chapter'];
    date = json['date'];
    businessCategory = json['businessCategory'];
    name = json['name'];
    contactNumber = json['contactNumber'];
    companyName = json['companyName'];
    addedBy = json['addedBy'];
    groupName = json['groupName'];
    title = json['title'];
    meetingDate = json['meetingDate'];
    email = json['email'];
    meetingCode = json['meetingCode'];
    profileUrl = json['profileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuId'] = this.uuId;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['chapter'] = this.chapter;
    data['date'] = this.date;
    data['businessCategory'] = this.businessCategory;
    data['name'] = this.name;
    data['contactNumber'] = this.contactNumber;
    data['companyName'] = this.companyName;
    data['addedBy'] = this.addedBy;
    data['groupName'] = this.groupName;
    data['title'] = this.title;
    data['meetingDate'] = this.meetingDate;
    data['meetingCode'] = this.meetingCode;
    data['email'] = this.email;
    data['profileUrl'] = this.profileUrl;
    return data;
  }
}
