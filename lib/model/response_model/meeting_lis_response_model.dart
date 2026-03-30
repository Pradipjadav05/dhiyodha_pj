import 'package:intl/intl.dart';

class MeetingListResponseModel {
  String? uuid;
  String? title;
  String? meetingDate;
  String? startTime;
  String? endTime;
  Location? location;
  Team? team;
  List<String>? attendeeIds;
  String? status;
  String? createdAt;
  String? createdBy;
  List<Media>? media;
  String? city;
  String? state;
  String? country;
  String? locationName;
  String? address;
  String? placeId;
  String? day;
  String? date;
  String? time;
  String? locationLink;

  MeetingListResponseModel({
    this.uuid,
    this.title,
    this.meetingDate,
    this.startTime,
    this.endTime,
    this.location,
    this.team,
    this.attendeeIds,
    this.status,
    this.createdAt,
    this.createdBy,
    this.media,
    this.city,
    this.state,
    this.country,
    this.locationName,
    this.address,
    this.placeId,
    this.day,
    this.date,
    this.time,
    this.locationLink,
  });

  factory MeetingListResponseModel.fromJson(Map<String, dynamic> json) {
    return MeetingListResponseModel(
      uuid: json['uuid'],
      title: json['title'],
      meetingDate: json['date'] != null && json['time'] != null
          ? (() {
              try {
                final d = DateFormat("MMMM dd, yyyy").parse(json['date']);
                final t = json['time'].split(":");

                return DateTime.utc(
                  d.year,
                  d.month,
                  d.day,
                  int.parse(t[0]),
                  int.parse(t[1]),
                ).toIso8601String();
              } catch (e) {
                return null;
              }
            })()
          : null,
      endTime: json['endTime'],
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      team: json['team'] != null ? Team.fromJson(json['team']) : null,
      attendeeIds: json['attendeeIds'] != null
          ? List<String>.from(json['attendeeIds'])
          : null,
      status: json['status'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      media: json['media'] != null
          ? (json['media'] as List).map((v) => Media.fromJson(v)).toList()
          : null,
      city: json['city'],
      state: json['state'],
      country: json['country'],
      locationName: json['locationName'],
      address: json['address'],
      placeId: json['place_id'],
      day: json['day'],
      date: json['date'],
      time: json['time'],
      locationLink: json['locationLink'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['title'] = title;
    data['meetingDate'] = meetingDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (attendeeIds != null) {
      data['attendeeIds'] = attendeeIds;
    }
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['locationName'] = locationName;
    data['address'] = address;
    data['place_id'] = placeId;
    data['day'] = day;
    data['date'] = date;
    data['time'] = time;
    data['locationLink'] = locationLink;
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class Media {
  String? title;
  String? imageUrl;

  Media({this.title, this.imageUrl});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}

class Team {
  String? id;
  String? uuid;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? groupName;
  String? description;
  int? groupLimit;
  List<TeamUser>? users;
  String? groupStatus;
  Region? region;
  String? groupAdmin;
  String? groupAdminName;
  String? meetingDay;
  String? country;
  String? state;
  String? city;
  bool? status;
  String? launchDate;

  Team({
    this.id,
    this.uuid,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.groupName,
    this.description,
    this.groupLimit,
    this.users,
    this.groupStatus,
    this.region,
    this.groupAdmin,
    this.groupAdminName,
    this.meetingDay,
    this.country,
    this.state,
    this.city,
    this.status,
    this.launchDate,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      uuid: json['uuid'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      updatedAt: json['updatedAt'],
      updatedBy: json['updatedBy'],
      groupName: json['groupName'],
      description: json['description'],
      groupLimit: json['groupLimit'],
      users: json['users'] != null
          ? (json['users'] as List).map((v) => TeamUser.fromJson(v)).toList()
          : null,
      groupStatus: json['groupStatus'],
      region: json['region'] != null ? Region.fromJson(json['region']) : null,
      groupAdmin: json['groupAdmin'],
      groupAdminName: json['groupAdminName'],
      meetingDay: json['meetingDay'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      status: json['status'],
      launchDate: json['launchDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['groupName'] = groupName;
    data['description'] = description;
    data['groupLimit'] = groupLimit;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    data['groupStatus'] = groupStatus;
    if (region != null) {
      data['region'] = region!.toJson();
    }
    data['groupAdmin'] = groupAdmin;
    data['groupAdminName'] = groupAdminName;
    data['meetingDay'] = meetingDay;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['status'] = status;
    data['launchDate'] = launchDate;
    return data;
  }
}

class Region {
  double? latitude;
  double? longitude;

  Region({this.latitude, this.longitude});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class TeamUser {
  String? id;
  String? uuid;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? firstName;
  String? lastName;
  String? email;
  String? dob;
  String? countryCode;
  String? mobileNo;
  String? uploadDocumentId;
  String? password;
  String? education;
  String? maritalStatus;
  String? teamId;
  String? profileUrl;
  bool? otpVerified;
  BusinessDetails? businessDetails;
  Address? address;
  List<Role>? roles;
  String? status;
  String? memberId;

  TeamUser({
    this.id,
    this.uuid,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.countryCode,
    this.mobileNo,
    this.uploadDocumentId,
    this.password,
    this.education,
    this.maritalStatus,
    this.teamId,
    this.profileUrl,
    this.otpVerified,
    this.businessDetails,
    this.address,
    this.roles,
    this.status,
    this.memberId,
  });

  factory TeamUser.fromJson(Map<String, dynamic> json) {
    return TeamUser(
      id: json['id'],
      uuid: json['uuid'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      updatedAt: json['updatedAt'],
      updatedBy: json['updatedBy'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      dob: json['dob'],
      countryCode: json['countryCode'],
      mobileNo: json['mobileNo'],
      uploadDocumentId: json['uploadDocumentId'],
      password: json['password'],
      education: json['education'],
      maritalStatus: json['maritalStatus'],
      teamId: json['teamId'],
      profileUrl: json['profileUrl'],
      otpVerified: json['otpVerified'],
      businessDetails: json['businessDetails'] != null
          ? BusinessDetails.fromJson(json['businessDetails'])
          : null,
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      roles: json['roles'] != null
          ? (json['roles'] as List).map((v) => Role.fromJson(v)).toList()
          : null,
      status: json['status'],
      memberId: json['memberId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['dob'] = dob;
    data['countryCode'] = countryCode;
    data['mobileNo'] = mobileNo;
    data['uploadDocumentId'] = uploadDocumentId;
    data['password'] = password;
    data['education'] = education;
    data['maritalStatus'] = maritalStatus;
    data['teamId'] = teamId;
    data['profileUrl'] = profileUrl;
    data['otpVerified'] = otpVerified;
    if (businessDetails != null) {
      data['businessDetails'] = businessDetails!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['memberId'] = memberId;
    return data;
  }
}

class BusinessDetails {
  String? id;
  String? uuid;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? companyName;
  String? companyEstablishment;
  String? companyAddress;
  String? registeredType;
  int? numberOfEmployees;
  String? yearlyTurnover;
  String? companyEmail;
  String? companyWebsite;
  String? companyContact;
  String? businessDescription;
  String? businessCategory;
  String? designation;
  int? yearlyProfit;
  String? gstNumber;
  String? uploadGst;
  String? panNumber;
  String? uploadPan;
  String? aadharNo;
  String? uploadAadhar;

  BusinessDetails({
    this.id,
    this.uuid,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.companyName,
    this.companyEstablishment,
    this.companyAddress,
    this.registeredType,
    this.numberOfEmployees,
    this.yearlyTurnover,
    this.companyEmail,
    this.companyWebsite,
    this.companyContact,
    this.businessDescription,
    this.businessCategory,
    this.designation,
    this.yearlyProfit,
    this.gstNumber,
    this.uploadGst,
    this.panNumber,
    this.uploadPan,
    this.aadharNo,
    this.uploadAadhar,
  });

  factory BusinessDetails.fromJson(Map<String, dynamic> json) {
    return BusinessDetails(
      id: json['id'],
      uuid: json['uuid'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      updatedAt: json['updatedAt'],
      updatedBy: json['updatedBy'],
      companyName: json['companyName'],
      companyEstablishment: json['companyEstablishment'],
      companyAddress: json['companyAddress'],
      registeredType: json['registeredType'],
      numberOfEmployees: json['numberOfEmployees'] != null
          ? (json['numberOfEmployees'] is int
              ? json['numberOfEmployees']
              : (json['numberOfEmployees'] as num).toInt())
          : null,
      yearlyTurnover: json['yearlyTurnover'],
      companyEmail: json['companyEmail'],
      companyWebsite: json['companyWebsite'],
      companyContact: json['companyContact'],
      businessDescription: json['businessDescription'],
      businessCategory: json['businessCategory'],
      designation: json['designation'],
      yearlyProfit: json['yearlyProfit'] != null
          ? (json['yearlyProfit'] is int
              ? json['yearlyProfit']
              : (json['yearlyProfit'] as num).toInt())
          : null,
      gstNumber: json['gstNumber'],
      uploadGst: json['uploadGst'],
      panNumber: json['panNumber'],
      uploadPan: json['uploadPan'],
      aadharNo: json['aadharNo'],
      uploadAadhar: json['uploadAadhar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'companyName': companyName,
      'companyEstablishment': companyEstablishment,
      'companyAddress': companyAddress,
      'registeredType': registeredType,
      'numberOfEmployees': numberOfEmployees,
      'yearlyTurnover': yearlyTurnover,
      'companyEmail': companyEmail,
      'companyWebsite': companyWebsite,
      'companyContact': companyContact,
      'businessDescription': businessDescription,
      'businessCategory': businessCategory,
      'designation': designation,
      'yearlyProfit': yearlyProfit,
      'gstNumber': gstNumber,
      'uploadGst': uploadGst,
      'panNumber': panNumber,
      'uploadPan': uploadPan,
      'aadharNo': aadharNo,
      'uploadAadhar': uploadAadhar,
    };
  }
}

class Address {
  String? id;
  String? uuid;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? status;

  Address({
    this.id,
    this.uuid,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.status,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      uuid: json['uuid'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      updatedAt: json['updatedAt'],
      updatedBy: json['updatedBy'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pinCode: json['pinCode'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'city': city,
      'state': state,
      'country': country,
      'pinCode': pinCode,
      'status': status,
    };
  }
}

class Role {
  String? id;
  String? uuid;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? roleName;
  List<dynamic>? privileges;

  Role({
    this.id,
    this.uuid,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.roleName,
    this.privileges,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      uuid: json['uuid'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      updatedAt: json['updatedAt'],
      updatedBy: json['updatedBy'],
      roleName: json['roleName'],
      privileges: json['privileges'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'roleName': roleName,
      'privileges': privileges,
    };
  }
}
