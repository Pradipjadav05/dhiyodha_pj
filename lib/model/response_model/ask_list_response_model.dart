class AskListResponseModel {
  String? timestamp;
  String? status;
  String? message;
  AskListData? askData;

  AskListResponseModel(
      {this.timestamp, this.status, this.message, this.askData});

  AskListResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    askData =
        json['data'] != null ? new AskListData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.askData != null) {
      data['data'] = this.askData?.toJson();
    }
    return data;
  }
}

class AskListData {
  List<AskListChild>? askChild;
  int? page;
  int? size;
  int? total;

  AskListData({this.askChild, this.page, this.size, this.total});

  AskListData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      askChild = [];
      json['data'].forEach((v) {
        askChild?.add(new AskListChild.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.askChild != null) {
      data['data'] = this.askChild?.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class AskListChild {
  String? askType;
  String? region;
  String? content;
  String? createdAt;
  String? firstName;
  String? lastName;
  String? profileUrl;
  String? city;
  String? state;
  String? createdBy;
  String? askUuid;

  AskListChild(
      {this.askType,
      this.region,
      this.content,
      this.createdAt,
      this.firstName,
      this.lastName,
      this.profileUrl,
      this.city,
      this.state,
      this.createdBy,
      this.askUuid});

  AskListChild.fromJson(Map<String, dynamic> json) {
    askType = json['askType'];
    region = json['region'];
    content = json['content'];
    createdAt = json['createdAt'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profileUrl = json['profileUrl'];
    city = json['city'];
    state = json['state'];
    createdBy = json['createdBy'];
    askUuid = json['askUuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['askType'] = this.askType;
    data['region'] = this.region;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profileUrl'] = this.profileUrl;
    data['city'] = this.city;
    data['state'] = this.state;
    data['createdBy'] = this.createdBy;
    data['askUuid'] = this.askUuid;
    return data;
  }
}
