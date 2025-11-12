class LoginResponse {
  String? timestamp;
  String? status;
  String? message;
  LoginAuthData? loginAuthData;

  LoginResponse(
      {this.timestamp, this.status, this.message, this.loginAuthData});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    loginAuthData = json['loginAuthData'] != null
        ? new LoginAuthData.fromJson(json['loginAuthData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.loginAuthData != null) {
      data['loginAuthData'] = this.loginAuthData!.toJson();
    }
    return data;
  }
}

class LoginAuthData {
  String? accessToken;
  String? refreshToken;

  LoginAuthData({this.accessToken, this.refreshToken});

  LoginAuthData.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
