class RentalRecordListBean {
  String msg;
  bool success;
  Result result;
  int statusCode;

  RentalRecordListBean({this.msg, this.success, this.result, this.statusCode});

  RentalRecordListBean.fromJson(Map<String, dynamic> json) {
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
  List<Records> records;
  int total;
  int size;
  int current;
  bool searchCount;
  int pages;

  Result(
      {this.records,
        this.total,
        this.size,
        this.current,
        this.searchCount,
        this.pages});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = new List<Records>();
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
    total = json['total'];
    size = json['size'];
    current = json['current'];
    searchCount = json['searchCount'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['size'] = this.size;
    data['current'] = this.current;
    data['searchCount'] = this.searchCount;
    data['pages'] = this.pages;
    return data;
  }
}

class Records {
  String orderId;
  String sn;
  String siteTypeName;
  String storeName;
  String storeImg;
  String status;
  String createTime;
  String completeTime;
  String deviceSn;
  DeviceType deviceType;
  String money;
  String usingTime;
  double earnings;
  int brokerage;
  double price;
  double dayMax;
  String chargerPrice;
  int freeTime;
  String nickName;
  String bankSn;
  String channel;
  String installTime;
  String payChannel;

  Records(
      {this.orderId,
        this.sn,
        this.siteTypeName,
        this.storeName,
        this.storeImg,
        this.status,
        this.createTime,
        this.completeTime,
        this.deviceSn,
        this.deviceType,
        this.money,
        this.usingTime,
        this.earnings,
        this.brokerage,
        this.price,
        this.dayMax,
        this.chargerPrice,
        this.freeTime,
        this.nickName,
        this.bankSn,
        this.channel,
        this.installTime,
        this.payChannel});

  Records.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    sn = json['sn'];
    siteTypeName = json['siteTypeName'];
    storeName = json['storeName'];
    storeImg = json['storeImg'];
    status = json['status'];
    createTime = json['createTime'];
    completeTime = json['completeTime'];
    deviceSn = json['deviceSn'];
    deviceType = json['deviceType'] != null
        ? new DeviceType.fromJson(json['deviceType'])
        : null;
    money = json['money'];
    usingTime = json['usingTime'];
    earnings = json['earnings'];
    brokerage = json['brokerage'];
    price = json['price'];
    dayMax = json['dayMax'];
    chargerPrice = json['chargerPrice'];
    freeTime = json['freeTime'];
    nickName = json['nickName'];
    bankSn = json['bankSn'];
    channel = json['channel'];
    installTime = json['installTime'];
    payChannel = json['payChannel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['sn'] = this.sn;
    data['siteTypeName'] = this.siteTypeName;
    data['storeName'] = this.storeName;
    data['storeImg'] = this.storeImg;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['completeTime'] = this.completeTime;
    data['deviceSn'] = this.deviceSn;
    if (this.deviceType != null) {
      data['deviceType'] = this.deviceType.toJson();
    }
    data['money'] = this.money;
    data['usingTime'] = this.usingTime;
    data['earnings'] = this.earnings;
    data['brokerage'] = this.brokerage;
    data['price'] = this.price;
    data['dayMax'] = this.dayMax;
    data['chargerPrice'] = this.chargerPrice;
    data['freeTime'] = this.freeTime;
    data['nickName'] = this.nickName;
    data['bankSn'] = this.bankSn;
    data['channel'] = this.channel;
    data['installTime'] = this.installTime;
    data['payChannel'] = this.payChannel;
    return data;
  }
}

class DeviceType {
  String desc;
  String value;

  DeviceType({this.desc, this.value});

  DeviceType.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['value'] = this.value;
    return data;
  }
}
