class VerifyOTPBean {
  String msg;
  bool success;
  Result result;
  int statusCode;

  VerifyOTPBean({this.msg, this.success, this.result, this.statusCode});

  VerifyOTPBean.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    success = json['success'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Result {
  String userId;
  String type;
  String name;
  String username;
  String mobile;
  String sessionId;
  String token;
  String avatar;
  String nationCode;
  String nationMobile;
  String email;

  Result(
      {this.userId,
        this.type,
        this.name,
        this.username,
        this.mobile,
        this.sessionId,
        this.token,
        this.avatar,
        this.nationCode,
        this.nationMobile,
        this.email});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    type = json['type'];
    name = json['name'];
    username = json['username'];
    mobile = json['mobile'];
    sessionId = json['sessionId'];
    token = json['token'];
    avatar = json['avatar'];
    nationCode = json['nationCode'];
    nationMobile = json['nationMobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['sessionId'] = this.sessionId;
    data['token'] = this.token;
    data['avatar'] = this.avatar;
    data['nationCode'] = this.nationCode;
    data['nationMobile'] = this.nationMobile;
    data['email'] = this.email;
    return data;
  }
}
