class NotificationBean {
  String msg;
  bool success;
  List<Result> result;
  int statusCode;

  NotificationBean({this.msg, this.success, this.result, this.statusCode});

  NotificationBean.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    success = json['success'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Result {
  String title;
  String body;
  String createTime;
  int notificationFor;
  String notificationId;
  RentDetails rentDetails;

  Result(
      {this.title,
        this.body,
        this.createTime,
        this.notificationFor,
        this.notificationId,
        this.rentDetails});

  Result.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    createTime = json['createTime'];
    notificationFor = json['notificationFor'];
    notificationId = json['notificationId'];
    rentDetails = json['rentDetails'] != null
        ? new RentDetails.fromJson(json['rentDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['createTime'] = this.createTime;
    data['notificationFor'] = this.notificationFor;
    data['notificationId'] = this.notificationId;
    if (this.rentDetails != null) {
      data['rentDetails'] = this.rentDetails.toJson();
    }
    return data;
  }
}

class RentDetails {
  String orderId;
  double price;

  RentDetails({this.orderId, this.price});

  RentDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['price'] = this.price;
    return data;
  }
}
