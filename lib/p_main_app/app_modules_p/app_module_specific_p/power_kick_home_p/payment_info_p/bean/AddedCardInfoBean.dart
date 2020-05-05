class AddedCardInfoBean {
  String msg;
  bool success;
  List<Result> result;
  int statusCode;

  AddedCardInfoBean({this.msg, this.success, this.result, this.statusCode});

  AddedCardInfoBean.fromJson(Map<String, dynamic> json) {
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
  String id;
  String createTime;
  String updateTime;
  String sn;
  String billKey;
  String cardName;
  String authDate;
  String cardCl;
  String appUserId;
  bool inUse;

  Result(
      {this.id,
        this.createTime,
        this.updateTime,
        this.sn,
        this.billKey,
        this.cardName,
        this.authDate,
        this.cardCl,
        this.appUserId,
        this.inUse});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    sn = json['sn'];
    billKey = json['billKey'];
    cardName = json['cardName'];
    authDate = json['authDate'];
    cardCl = json['cardCl'];
    appUserId = json['appUserId'];
    inUse = json['inUse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['sn'] = this.sn;
    data['billKey'] = this.billKey;
    data['cardName'] = this.cardName;
    data['authDate'] = this.authDate;
    data['cardCl'] = this.cardCl;
    data['appUserId'] = this.appUserId;
    data['inUse'] = this.inUse;
    return data;
  }
}