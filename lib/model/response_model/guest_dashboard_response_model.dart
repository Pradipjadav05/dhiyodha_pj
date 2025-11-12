class GuestDashboardResponseModel {
  String? timestamp;
  String? status;
  String? message;
  List<Data>? data;

  GuestDashboardResponseModel(
      {this.timestamp, this.status, this.message, this.data});

  GuestDashboardResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<ImageList>? imageList;
  List<String>? reelList;

  Data({this.imageList, this.reelList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['imageList'] != null) {
      imageList = <ImageList>[];
      json['imageList'].forEach((v) {
        imageList!.add(new ImageList.fromJson(v));
      });
    }
    reelList = json['reelList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.imageList != null) {
      data['imageList'] = this.imageList!.map((v) => v.toJson()).toList();
    }
    data['reelList'] = this.reelList;
    return data;
  }
}

class ImageList {
  String? id;
  String? uuid;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? url;
  String? fileName;
  String? documentType;
  String? associatedId;

  ImageList(
      {this.id,
      this.uuid,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.url,
      this.fileName,
      this.documentType,
      this.associatedId});

  ImageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    url = json['url'];
    fileName = json['fileName'];
    documentType = json['documentType'];
    associatedId = json['associatedId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['updatedAt'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    data['url'] = this.url;
    data['fileName'] = this.fileName;
    data['documentType'] = this.documentType;
    data['associatedId'] = this.associatedId;
    return data;
  }
}
