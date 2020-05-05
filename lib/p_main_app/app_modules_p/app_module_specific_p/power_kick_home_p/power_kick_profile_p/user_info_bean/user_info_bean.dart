class UserInfoBean {
  String msg;
  bool success;
  Result result;
  int statusCode;

  UserInfoBean({this.msg, this.success, this.result, this.statusCode});

  UserInfoBean.fromJson(Map<String, dynamic> json) {
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
  String mobile;
  String nickName;
  String money;
  String costMoney;
  String email;
  String avatar;
  String id;
  String appCode;
  bool paid;

  Result(
      {this.mobile,
        this.nickName,
        this.money,
        this.costMoney,
        this.email,
        this.avatar,
        this.id,
        this.appCode,
        this.paid});

  Result.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    nickName = json['nickName'];
    money = json['money'];
    costMoney = json['costMoney'];
    email = json['email'];
    avatar = json['avatar'];
    id = json['id'];
    appCode = json['appCode'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['nickName'] = this.nickName;
    data['money'] = this.money;
    data['costMoney'] = this.costMoney;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['appCode'] = this.appCode;
    data['paid'] = this.paid;
    return data;
  }
}
