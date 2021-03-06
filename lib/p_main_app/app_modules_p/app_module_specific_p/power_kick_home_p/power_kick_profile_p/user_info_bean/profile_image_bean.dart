class ProfileImageBean {
  String msg;
  bool success;
  String result;
  int statusCode;

  ProfileImageBean({this.msg, this.success, this.result, this.statusCode});

  ProfileImageBean.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    success = json['success'];
    result = json['result'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['success'] = this.success;
    data['result'] = this.result;
    data['statusCode'] = this.statusCode;
    return data;
  }
}
