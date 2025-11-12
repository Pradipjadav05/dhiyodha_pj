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
  String? referralTo;
  String? type;
  List<String>? status;
  String? referral;
  String? telephone;
  String? email;
  String? address;
  String? comment;
  double? rate;
  String? createdAt;
  String? createdBy;

  ReferralChildData(
      {this.uuid,
      this.referralTo,
      this.type,
      this.status,
      this.referral,
      this.telephone,
      this.email,
      this.address,
      this.comment,
      this.rate,
      this.createdAt,
      this.createdBy});

  ReferralChildData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    referralTo = json['referralTo'];
    type = json['type'];
    status = json['status'].cast<String>();
    referral = json['referral'];
    telephone = json['telephone'];
    email = json['email'];
    address = json['address'];
    comment = json['comment'];
    rate = json['rate'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['referralTo'] = this.referralTo;
    data['type'] = this.type;
    data['status'] = this.status;
    data['referral'] = this.referral;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['comment'] = this.comment;
    data['rate'] = this.rate;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
