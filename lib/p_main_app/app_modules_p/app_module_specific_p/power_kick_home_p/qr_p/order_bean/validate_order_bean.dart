class ValidateOrderBean {
  String msg;
  bool success;
  Result result;
  int statusCode;

  ValidateOrderBean({this.msg, this.success, this.result, this.statusCode});

  ValidateOrderBean.fromJson(Map<String, dynamic> json) {
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
  int status;
  String orderSn;

  Result({this.status, this.orderSn});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderSn = json['orderSn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['orderSn'] = this.orderSn;
    return data;
  }
}
