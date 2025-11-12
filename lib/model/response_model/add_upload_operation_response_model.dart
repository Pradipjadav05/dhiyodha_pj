class AddUploadOperationResponseModel {
  String? timestamp;
  String? status;
  String? message;
  dynamic data;

  AddUploadOperationResponseModel(
      {this.timestamp, this.status, this.message, this.data});

  AddUploadOperationResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}

class UploadedDocRespModel {
  String? url;
  String? fileName;
  String? associatedId;
  String? documentType;
  String? createdAt;
  String? updatedAt;
  String? documentUuid;

  UploadedDocRespModel(
      {this.url,
      this.fileName,
      this.associatedId,
      this.documentType,
      this.createdAt,
      this.updatedAt,
      this.documentUuid});

  UploadedDocRespModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    fileName = json['fileName'];
    associatedId = json['associatedId'];
    documentType = json['documentType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    documentUuid = json['documentUuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['fileName'] = this.fileName;
    data['associatedId'] = this.associatedId;
    data['documentType'] = this.documentType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['documentUuid'] = this.documentUuid;
    return data;
  }

  Map<String, String> getOnlyDocUuid() {
    final Map<String, String> data = new Map<String, String>();
    data['documentUuid'] = this.documentUuid!;
    return data;
  }
}

class AskData {
  String? askType;
  String? region;
  String? content;
  String? createdAt;
  String? createdBy;
  String? askUuid;

  AskData(
      {this.askType,
      this.region,
      this.content,
      this.createdAt,
      this.createdBy,
      this.askUuid});

  AskData.fromJson(Map<String, dynamic> json) {
    askType = json['askType'];
    region = json['region'];
    content = json['content'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    askUuid = json['askUuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['askType'] = this.askType;
    data['region'] = this.region;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['askUuid'] = this.askUuid;
    return data;
  }
}

class AddPostData {
  String? title;
  String? content;
  String? imageUrl;
  int? likesCounter;
  String? postRegion;
  int? commentsCounter;
  List<dynamic>? comments;
  List<dynamic>? likes;
  String? createdAt;
  String? createdBy;
  bool? active;
  String? postUuid;

  AddPostData({
    this.title,
    this.content,
    this.imageUrl,
    this.likesCounter,
    this.postRegion,
    this.commentsCounter,
    this.comments,
    this.likes,
    this.createdAt,
    this.createdBy,
    this.active,
    this.postUuid,
  });

  AddPostData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    imageUrl = json['imageUrl'];
    likesCounter = json['likesCounter'];
    postRegion = json['postRegion'];
    commentsCounter = json['commentsCounter'];
    if (json['comments'] != null) {
      comments = <dynamic>[];
      json['comments'].forEach((v) {
        // comments!.add(new Null.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <dynamic>[];
      json['likes'].forEach((v) {
        // likes!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    active = json['active'];
    postUuid = json['postUuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['imageUrl'] = this.imageUrl;
    data['likesCounter'] = this.likesCounter;
    data['postRegion'] = this.postRegion;
    data['commentsCounter'] = this.commentsCounter;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['active'] = this.active;
    data['postUuid'] = this.postUuid;
    return data;
  }
}

class UploadDocument {
  String? documentType;
  String? createdAt;
  String? createdBy;
  String? documentUuid;

  UploadDocument(
      {this.documentType, this.documentUuid, this.createdAt, this.createdBy});

  UploadDocument.fromJson(Map<String, dynamic> json) {
    documentType = json['documentType'];
    documentUuid = json['documentUuid'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentType'] = this.documentType;
    data['documentUuid'] = this.documentUuid;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
