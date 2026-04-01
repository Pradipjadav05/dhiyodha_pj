import 'package:dhiyodha/utils/resource/app_media_assets.dart';

class PostsModel {
  String? timestamp;
  String? status;
  String? message;
  PostData? postData;

  PostsModel({this.timestamp, this.status, this.message, this.postData});

  PostsModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    postData =
        json['data'] != null ? new PostData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.postData != null) {
      data['data'] = this.postData!.toJson();
    }
    return data;
  }
}

class PostData {
  List<PostChildData>? postChildData;
  int? page;
  int? size;
  int? total;

  PostData({this.postChildData, this.page, this.size, this.total});

  PostData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      postChildData = <PostChildData>[];
      json['data'].forEach((v) {
        postChildData!.add(new PostChildData.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.postChildData != null) {
      data['data'] = this.postChildData!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class PostChildData {
  String? title;
  String? content;
  String? firstName;
  String? lastName;
  String? profileUrl;
  String? imageUrl;
  int? likesCounter;
  String? postRegion;
  int? commentsCounter;
  List<Comments>? comments;
  AddressDTO? addressDTO;
  List<Likes>? likes;
  String? createdAt;
  String? createdBy;
  bool? active;
  String? postUuid;

  bool isLikeLoading = false;
  bool isPostLiked = false;

  PostChildData(
      {this.title,
      this.content,
      this.firstName,
      this.lastName,
      this.profileUrl,
      this.imageUrl,
      this.likesCounter,
      this.postRegion,
      this.commentsCounter,
      this.comments,
      this.likes,
      this.createdAt,
      this.createdBy,
      this.active,
      this.postUuid});

  PostChildData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    imageUrl = json['imageUrl'];
    profileUrl = json['profileUrl'];
    likesCounter = json['likesCounter'];
    postRegion = json['postRegion'];
    commentsCounter = json['commentsCounter'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    if (json['addressDTO'] != null) {
      addressDTO = AddressDTO.fromJson(json['addressDTO']);
    }
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
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
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profileUrl'] = this.profileUrl;
    data['imageUrl'] = this.imageUrl;
    data['likesCounter'] = this.likesCounter;
    data['postRegion'] = this.postRegion;
    data['commentsCounter'] = this.commentsCounter;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.addressDTO != null) {
      data['addressDTO'] = this.addressDTO!.toJson();
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

class Comments {
  String? commentUuid;
  String? comment;
  String? userId;
  String? createdAt;

  Comments({this.commentUuid, this.comment, this.userId, this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    commentUuid = json['commentUuid'];
    comment = json['comment'];
    userId = json['userId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentUuid'] = this.commentUuid;
    data['comment'] = this.comment;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class AddressDTO {
  String? city;
  String? state;
  String? country;
  String? pinCode;

  AddressDTO({this.city, this.state, this.country, this.pinCode});

  AddressDTO.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pinCode = json['pinCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pinCode'] = this.pinCode;
    return data;
  }
}

class Likes {
  String? userId;
  String? instant;

  Likes({this.userId, this.instant});

  Likes.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    instant = json['instant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['instant'] = this.instant;
    return data;
  }
}
