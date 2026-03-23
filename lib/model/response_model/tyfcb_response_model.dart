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
    tyfcbData = json['data'] != null ? TyfcbData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['status'] = status;
    data['message'] = message;
    if (tyfcbData != null) {
      data['data'] = tyfcbData!.toJson();
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
      tyfcbChildData = (json['data'] as List)
          .map((e) => TyfcbChildData.fromJson(e))
          .toList();
    }
    page = json['page'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    return {
      'data': tyfcbChildData?.map((e) => e.toJson()).toList(),
      'page': page,
      'size': size,
      'total': total,
    };
  }
}

class TyfcbChildData {
  String? uuid;
  Recipient? recipient; // ✅ FIXED
  double? giftAmount;
  String? businessType;
  String? referralType;
  String? comments;
  MeetingDetails? meetingDetails;
  String? createdBy;
  String? createdAt;

  TyfcbChildData({
    this.uuid,
    this.recipient,
    this.giftAmount,
    this.businessType,
    this.referralType,
    this.comments,
    this.meetingDetails,
    this.createdBy,
    this.createdAt,
  });

  TyfcbChildData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];

    recipient = json['recipientId'] != null
        ? Recipient.fromJson(json['recipientId'])
        : null;

    giftAmount = (json['giftAmount'] as num?)?.toDouble();

    businessType = json['businessType'];
    referralType = json['referralType'];
    comments = json['comments'];

    meetingDetails = json['meetingDetails'] != null
        ? MeetingDetails.fromJson(json['meetingDetails'])
        : null;

    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'recipientId': recipient?.toJson(),
      'giftAmount': giftAmount,
      'businessType': businessType,
      'referralType': referralType,
      'comments': comments,
      'meetingDetails': meetingDetails?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }
}

class Recipient {
  String? id;
  String? uuid;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? profileUrl;

  Recipient({
    this.id,
    this.uuid,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNo,
    this.profileUrl,
  });

  Recipient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    profileUrl = json['profileUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNo': mobileNo,
      'profileUrl': profileUrl,
    };
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

  MeetingDetails({
    this.uuid,
    this.title,
    this.meetingDate,
    this.location,
    this.status,
    this.createdAt,
    this.createdBy,
  });

  MeetingDetails.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    title = json['title'];
    meetingDate = json['meetingDate'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    status = json['status'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'title': title,
      'meetingDate': meetingDate,
      'location': location?.toJson(),
      'status': status,
      'createdAt': createdAt,
      'createdBy': createdBy,
    };
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
