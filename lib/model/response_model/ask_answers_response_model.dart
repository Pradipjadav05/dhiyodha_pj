class AskAnswersResponseModel {
  String? timestamp;
  String? status;
  String? message;
  AskAnswerData? askAnswerData;

  AskAnswersResponseModel(
      {this.timestamp, this.status, this.message, this.askAnswerData});

  AskAnswersResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    askAnswerData =
        json['data'] != null ? new AskAnswerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.askAnswerData != null) {
      data['data'] = this.askAnswerData!.toJson();
    }
    return data;
  }
}

class AskAnswerData {
  String? askType;
  String? region;
  String? content;
  List<AnswerList>? answerList;
  String? createdAt;
  String? createdBy;
  String? askUuid;

  AskAnswerData(
      {this.askType,
      this.region,
      this.content,
      this.answerList,
      this.createdAt,
      this.createdBy,
      this.askUuid});

  AskAnswerData.fromJson(Map<String, dynamic> json) {
    askType = json['askType'];
    region = json['region'];
    content = json['content'];
    if (json['answerList'] != null) {
      answerList = <AnswerList>[];
      json['answerList'].forEach((v) {
        answerList!.add(new AnswerList.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    askUuid = json['askUuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['askType'] = this.askType;
    data['region'] = this.region;
    data['content'] = this.content;
    if (this.answerList != null) {
      data['answerList'] = this.answerList!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['askUuid'] = this.askUuid;
    return data;
  }
}

class AnswerList {
  String? answer;
  String? userUuid;
  String? answerAt;

  AnswerList({this.answer, this.userUuid, this.answerAt});

  AnswerList.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    userUuid = json['userUuid'];
    answerAt = json['answerAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['userUuid'] = this.userUuid;
    data['answerAt'] = this.answerAt;
    return data;
  }
}
