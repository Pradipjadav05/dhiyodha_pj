class TyfcbResponseModel {
  String? timestamp;
  String? status;
  String? message;
  TyfcbData? tyfcbData;

  TyfcbResponseModel(
      {this.timestamp, this.status, this.message, this.tyfcbData});

  TyfcbResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    tyfcbData =
        json['data'] != null ? new TyfcbData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tyfcbData != null) {
      data['data'] = this.tyfcbData!.toJson();
    }
    return data;
  }
}

class TyfcbData {
  List<TyfcbChildData>? tyfcbChildData;
  int? page;
  int? size;
  int? total;

  TyfcbData({this.tyfcbChildData, this.page, this.size, this.total});

  TyfcbData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      tyfcbChildData = <TyfcbChildData>[];
      json['data'].forEach((v) {
        tyfcbChildData!.add(new TyfcbChildData.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tyfcbChildData != null) {
      data['data'] = this.tyfcbChildData!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class TyfcbChildData {
  String? uuid;
  String? recipientId;
  double? giftAmount;
  String? businessType;
  String? referralType;
  String? comments;
  MeetingDetails? meetingDetails;
  String? createdBy;
  String? createdAt;

  TyfcbChildData(
      {this.uuid,
      this.recipientId,
      this.giftAmount,
      this.businessType,
      this.referralType,
      this.comments,
      this.meetingDetails,
      this.createdBy,
      this.createdAt});

  TyfcbChildData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    recipientId = json['recipientId'];
    giftAmount = json['giftAmount'];
    businessType = json['businessType'];
    referralType = json['referralType'];
    comments = json['comments'];
    meetingDetails = json['meetingDetails'] != null
        ? new MeetingDetails.fromJson(json['meetingDetails'])
        : null;
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['recipientId'] = this.recipientId;
    data['giftAmount'] = this.giftAmount;
    data['businessType'] = this.businessType;
    data['referralType'] = this.referralType;
    data['comments'] = this.comments;
    if (this.meetingDetails != null) {
      data['meetingDetails'] = this.meetingDetails!.toJson();
    }
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class MeetingDetails {
  String? uuid;
  String? title;
  String? meetingDate;
  Location? location;
  String? status;
  String? createdAt;
  String? createdBy;

  MeetingDetails(
      {this.uuid,
      this.title,
      this.meetingDate,
      this.location,
      this.status,
      this.createdAt,
      this.createdBy});

  MeetingDetails.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    title = json['title'];
    meetingDate = json['meetingDate'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['meetingDate'] = this.meetingDate;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
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
