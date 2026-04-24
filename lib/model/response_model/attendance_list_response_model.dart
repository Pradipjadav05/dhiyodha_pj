class AttendanceListResponseModel {
  String? timestamp;
  String? status;
  String? message;
  AttendanceData? data;

  AttendanceListResponseModel({this.timestamp, this.status, this.message, this.data});

  AttendanceListResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AttendanceData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AttendanceData {
  List<AttendanceItem>? data;
  int? page;
  int? size;
  int? currentCount;
  int? total;

  AttendanceData({this.data, this.page, this.size, this.currentCount, this.total});

  AttendanceData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AttendanceItem>[];
      json['data'].forEach((v) {
        data!.add(AttendanceItem.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    currentCount = json['currentCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['size'] = size;
    data['currentCount'] = currentCount;
    data['total'] = total;
    return data;
  }
}

class AttendanceItem {
  AttendanceMeeting? meeting;
  int? members;
  int? present;
  int? absent;
  int? substitute;
  List<AttendanceMemberDetail>? memberDetails;

  AttendanceItem(
      {this.meeting,
      this.members,
      this.present,
      this.absent,
      this.substitute,
      this.memberDetails});

  AttendanceItem.fromJson(Map<String, dynamic> json) {
    meeting =
        json['meeting'] != null ? AttendanceMeeting.fromJson(json['meeting']) : null;
    members = json['members'];
    present = json['present'];
    absent = json['absent'];
    substitute = json['substitute'];
    if (json['memberDetails'] != null) {
      memberDetails = <AttendanceMemberDetail>[];
      json['memberDetails'].forEach((v) {
        memberDetails!.add(AttendanceMemberDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meeting != null) {
      data['meeting'] = meeting!.toJson();
    }
    data['members'] = members;
    data['present'] = present;
    data['absent'] = absent;
    data['substitute'] = substitute;
    if (memberDetails != null) {
      data['memberDetails'] =
          memberDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceMeeting {
  String? id;
  String? uuid;
  String? title;
  String? meetingDate;
  String? startTime;
  String? endTime;
  String? city;
  String? state;
  String? country;
  String? status;
  String? locationName;
  String? address;
  String? placeId;
  String? meetingtitle;
  String? meetingBanner;
  String? locationLink;

  AttendanceMeeting(
      {this.id,
      this.uuid,
      this.title,
      this.meetingDate,
      this.startTime,
      this.endTime,
      this.city,
      this.state,
      this.country,
      this.status,
      this.locationName,
      this.address,
      this.placeId,
      this.meetingtitle,
      this.meetingBanner,
      this.locationLink});

  AttendanceMeeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    meetingDate = json['meetingDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    status = json['status'];
    locationName = json['locationName'];
    address = json['address'];
    placeId = json['place_id'];
    meetingtitle = json['meetingtitle'];
    meetingBanner = json['meetingBanner'];
    locationLink = json['locationLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['title'] = title;
    data['meetingDate'] = meetingDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['status'] = status;
    data['locationName'] = locationName;
    data['address'] = address;
    data['place_id'] = placeId;
    data['meetingtitle'] = meetingtitle;
    data['meetingBanner'] = meetingBanner;
    data['locationLink'] = locationLink;
    return data;
  }
}

class AttendanceMemberDetail {
  String? memberId;
  String? memberName;
  String? status;

  AttendanceMemberDetail({this.memberId, this.memberName, this.status});

  AttendanceMemberDetail.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    memberName = json['memberName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberId'] = memberId;
    data['memberName'] = memberName;
    data['status'] = status;
    return data;
  }
}
