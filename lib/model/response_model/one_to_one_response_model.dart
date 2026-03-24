class OneToOneResponseModel {
  String? timestamp;
  String? status;
  String? message;
  OneToOneData? data;

  OneToOneResponseModel({this.timestamp, this.status, this.message, this.data});

  OneToOneResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? OneToOneData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class OneToOneData {
  List<OneToOneChildData>? data;
  int? page;
  int? size;
  int? total;

  OneToOneData({this.data, this.page, this.size, this.total});

  OneToOneData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OneToOneChildData>[];
      json['data'].forEach((v) {
        data!.add(OneToOneChildData.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((v) => v.toJson()).toList(),
      'page': page,
      'size': size,
      'total': total,
    };
  }
}

class OneToOneChildData {
  String? uuid;
  OneToOneUser? connectedWith;
  OneToOneUser? initiatedBy;
  String? oneToOneDate;
  String? oneToOneNotes;
  OneToOneLocationModel? oneToOneLocation;
  String? createdAt;
  String? createdBy;

  OneToOneChildData({
    this.uuid,
    this.connectedWith,
    this.initiatedBy,
    this.oneToOneDate,
    this.oneToOneNotes,
    this.oneToOneLocation,
    this.createdAt,
    this.createdBy,
  });

  OneToOneChildData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];

    // ✅ FIXED connectedWith
    if (json['connectedWith'] is Map) {
      connectedWith = OneToOneUser.fromJson(json['connectedWith']);
    } else if (json['connectedWith'] is String) {
      connectedWith = OneToOneUser(firstName: json['connectedWith']);
    }

    // ✅ FIXED initiatedBy
    if (json['initiatedBy'] is Map) {
      initiatedBy = OneToOneUser.fromJson(json['initiatedBy']);
    } else if (json['initiatedBy'] is String) {
      initiatedBy = OneToOneUser(firstName: json['initiatedBy']);
    }

    oneToOneDate = json['oneToOneDate'];
    oneToOneNotes = json['oneToOneNotes'];

    oneToOneLocation = json['oneToOneLocation'] != null
        ? OneToOneLocationModel.fromJson(json['oneToOneLocation'])
        : null;

    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'connectedWith': connectedWith?.toJson(),
      'initiatedBy': initiatedBy?.toJson(),
      'oneToOneDate': oneToOneDate,
      'oneToOneNotes': oneToOneNotes,
      'oneToOneLocation': oneToOneLocation?.toJson(),
      'createdAt': createdAt,
      'createdBy': createdBy,
    };
  }
}

class OneToOneUser {
  String? uuid;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? profileUrl;

  OneToOneUser({
    this.uuid,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNo,
    this.profileUrl,
  });

  OneToOneUser.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    profileUrl = json['profileUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNo': mobileNo,
      'profileUrl': profileUrl,
    };
  }
}

class OneToOneLocationModel {
  double? latitude;
  double? longitude;

  OneToOneLocationModel({this.latitude, this.longitude});

  OneToOneLocationModel.fromJson(Map<String, dynamic> json) {
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