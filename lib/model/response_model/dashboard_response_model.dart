class DashboardResponseModel {
  String? timestamp;
  String? status;
  String? message;
  DashboardData? dashboardData;

  DashboardResponseModel(
      {this.timestamp, this.status, this.message, this.dashboardData});

  DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    dashboardData =
        json['data'] != null ? new DashboardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dashboardData != null) {
      data['data'] = this.dashboardData!.toJson();
    }
    return data;
  }
}

class DashboardData {
  String? name;
  String? utsav;
  String? dueDate;
  List<Stats>? stats;
  List<Documents>? documents;
  NextMeeting? nextMeeting;

  DashboardData(
      {this.name,
      this.utsav,
      this.dueDate,
      this.stats,
      this.documents,
      this.nextMeeting});

  DashboardData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    utsav = json['utsav'];
    dueDate = json['dueDate'];
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(new Stats.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
    nextMeeting = json['nextMeeting'] != null
        ? new NextMeeting.fromJson(json['nextMeeting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['utsav'] = this.utsav;
    data['dueDate'] = this.dueDate;
    if (this.stats != null) {
      data['stats'] = this.stats!.map((v) => v.toJson()).toList();
    }
    if (this.nextMeeting != null) {
      data['nextMeeting'] = this.nextMeeting!.toJson();
    }
    return data;
  }
}

class Stats {
  String? asset;
  String? name;
  int? count;

  Stats({this.asset, this.name, this.count});

  Stats.fromJson(Map<String, dynamic> json) {
    asset = json['asset'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asset'] = this.asset;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class Documents {
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
  String? groupUuid;
  int? count;

  Documents(
      {this.id,
      this.uuid,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.url,
      this.fileName,
      this.documentType,
      this.associatedId,
      this.groupUuid,
      this.count});

  Documents.fromJson(Map<String, dynamic> json) {
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
    groupUuid = json['groupUuid'];
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
    data['groupUuid'] = this.groupUuid;
    return data;
  }
}

class NextMeeting {
  String? uuid;
  String? day;
  String? date;
  String? startTime;
  String? endTime;
  String? meetingType;
  String? title;
  int? tyfcb;
  int? tyfcbReceived;
  int? speakers;
  int? visitors;
  int? trainer;
  int? guest;

  NextMeeting(
      {this.day,
      this.uuid,
      this.startTime,
      this.endTime,
      this.date,
      this.meetingType,
      this.tyfcb,
      this.tyfcbReceived,
      this.speakers,
      this.visitors,
      this.trainer,
      this.guest, this. title});

  NextMeeting.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    date = json['date'];
    uuid = json['uuid'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    meetingType = json['meetingType'];
    tyfcb = json['tyfcb'];
    tyfcbReceived = json['tyfcbReceived'];
    speakers = json['speakers'];
    visitors = json['visitors'];
    trainer = json['trainer'];
    guest = json['guest'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['date'] = this.date;
    data['uuid'] = this.uuid;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['meetingType'] = this.meetingType;
    data['tyfcb'] = this.tyfcb;
    data['tyfcbReceived'] = this.tyfcbReceived;
    data['speakers'] = this.speakers;
    data['visitors'] = this.visitors;
    data['trainer'] = this.trainer;
    data['guest'] = this.guest;
    data['title'] = this.title;
    return data;
  }
}
