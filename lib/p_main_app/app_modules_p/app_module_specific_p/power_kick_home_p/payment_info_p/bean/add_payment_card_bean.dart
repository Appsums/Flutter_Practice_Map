class AddPaymentCardBean {
  String msg;
  bool success;
  Result result;
  int statusCode;

  AddPaymentCardBean({this.msg, this.success, this.result, this.statusCode});

  AddPaymentCardBean.fromJson(Map<String, dynamic> json) {
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
  String msg;
  bool success;
  String type;

  Result({this.msg, this.success, this.type});

  Result.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    success = json['success'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['success'] = this.success;
    data['type'] = this.type;
    return data;
  }
}