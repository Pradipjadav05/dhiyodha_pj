class ReferralResponseModel {
  String? timestamp;
  String? status;
  String? message;
  ReferralData? referralData;

  ReferralResponseModel(
      {this.timestamp, this.status, this.message, this.referralData});

  ReferralResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    referralData =
        json['data'] != null ? new ReferralData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.referralData != null) {
      data['data'] = this.referralData!.toJson();
    }
    return data;
  }
}

class ReferralData {
  List<ReferralChildData>? referralChildData;
  int? page;
  int? size;
  int? total;

  ReferralData({this.referralChildData, this.page, this.size, this.total});

  ReferralData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      referralChildData = <ReferralChildData>[];
      json['data'].forEach((v) {
        referralChildData!.add(new ReferralChildData.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.referralChildData != null) {
      data['data'] = this.referralChildData!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class ReferralChildData {
  String? uuid;
  ReferralUser? referralTo; // ✅ FIXED
  String? type;
  List<String>? status;
  String? referral;
  String? telephone;
  String? email;
  String? address;
  String? comments;
  double? rate;
  String? createdAt;
  String? createdBy;
  String? referralType;
  String? referralStatus;
  String? companyName;

  ReferralChildData({
    this.uuid,
    this.referralTo,
    this.type,
    this.status,
    this.referral,
    this.telephone,
    this.email,
    this.address,
    this.comments,
    this.rate,
    this.createdAt,
    this.createdBy,
    this.referralType,
    this.referralStatus,
    this.companyName,
  });

  ReferralChildData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];

    referralTo = json['referralTo'] != null
        ? ReferralUser.fromJson(json['referralTo'])
        : null;

    type = json['type'];

    if (json['status'] != null) {
      status = List<String>.from(json['status']);
    }

    referral = json['referral'];
    telephone = json['telephone'];
    email = json['email'];
    address = json['address'];
    comments = json['comments'];

    rate = (json['rate'] as num?)?.toDouble();

    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    referralType = json['referralType'];
    referralStatus = json['referralStatus'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'referralTo': referralTo?.toJson(),
      'type': type,
      'status': status,
      'referral': referral,
      'telephone': telephone,
      'email': email,
      'address': address,
      'comments': comments,
      'rate': rate,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'referralType': referralType,
      'referralStatus': referralStatus,
      'companyName': companyName,
    };
  }
}

class ReferralUser {
  String? id;
  String? uuid;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? profileUrl;

  ReferralUser({
    this.id,
    this.uuid,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNo,
    this.profileUrl,
  });

  ReferralUser.fromJson(Map<String, dynamic> json) {
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
