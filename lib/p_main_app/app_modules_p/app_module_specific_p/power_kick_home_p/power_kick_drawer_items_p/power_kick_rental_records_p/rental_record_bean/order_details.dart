class OrderDetails {
  String msg;
  bool success;
  Result result;
  int statusCode;

  OrderDetails({this.msg, this.success, this.result, this.statusCode});

  OrderDetails.fromJson(Map<String, dynamic> json) {
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
  OrderStoreSnapshot orderStoreSnapshot;
  String orderStatus;
  String orderSn;
  String usingTime;
  String createTime;
  String completeTime;
  String money;
  DeviceType deviceType;
  String deviceSn;
  String channel;
  String password;
  String bankSn;
  int freeMinutes;
  String rentTime;
  String backTime;
  String backDeviceSn;
  String backAddress;

  Result(
      {this.orderStoreSnapshot,
        this.orderStatus,
        this.orderSn,
        this.usingTime,
        this.createTime,
        this.completeTime,
        this.money,
        this.deviceType,
        this.deviceSn,
        this.channel,
        this.password,
        this.bankSn,
        this.freeMinutes,
        this.rentTime,
        this.backTime,
        this.backDeviceSn,
        this.backAddress});

  Result.fromJson(Map<String, dynamic> json) {
    orderStoreSnapshot = json['orderStoreSnapshot'] != null
        ? new OrderStoreSnapshot.fromJson(json['orderStoreSnapshot'])
        : null;
    orderStatus = json['orderStatus'];
    orderSn = json['orderSn'];
    usingTime = json['usingTime'];
    createTime = json['createTime'];
    completeTime = json['completeTime'];
    money = json['money'];
    deviceType = json['deviceType'] != null
        ? new DeviceType.fromJson(json['deviceType'])
        : null;
    deviceSn = json['deviceSn'];
    channel = json['channel'];
    password = json['password'];
    bankSn = json['bankSn'];
    freeMinutes = json['freeMinutes'];
    rentTime = json['rentTime'];
    backTime = json['backTime'];
    backDeviceSn = json['backDeviceSn'];
    backAddress = json['backAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderStoreSnapshot != null) {
      data['orderStoreSnapshot'] = this.orderStoreSnapshot.toJson();
    }
    data['orderStatus'] = this.orderStatus;
    data['orderSn'] = this.orderSn;
    data['usingTime'] = this.usingTime;
    data['createTime'] = this.createTime;
    data['completeTime'] = this.completeTime;
    data['money'] = this.money;
    if (this.deviceType != null) {
      data['deviceType'] = this.deviceType.toJson();
    }
    data['deviceSn'] = this.deviceSn;
    data['channel'] = this.channel;
    data['password'] = this.password;
    data['bankSn'] = this.bankSn;
    data['freeMinutes'] = this.freeMinutes;
    data['rentTime'] = this.rentTime;
    data['backTime'] = this.backTime;
    data['backDeviceSn'] = this.backDeviceSn;
    data['backAddress'] = this.backAddress;
    return data;
  }
}

class OrderStoreSnapshot {
  String id;
  String createTime;
  String updateTime;
  String proxyUserId;
  String agentId;
  int agentLevel;
  int storeBrokerage;
  String storeCreateTime;
  String storeUpdateTime;
  String storeName;
  String siteId;
  String dicSiteCode;
  String dicSiteName;
  int dicSiteLevel;
  String beginTime;
  String endTime;
  String servicePhone;
  String address;
  double longitude;
  double latitude;
  String advLink;
  String advImg;
  String proxyUserName;
  String proxyUserMobile;
  String agentName;
  String agentMobile;
  String chargerPrice;
  double price;
  double dayMax;
  String storeId;
  String orderId;
  String deviceInfoId;
  String orderSn;
  int freeTime;
  String cagentId;
  int cagentBrokerage;
  String bagentId;
  int bagentBrokerage;
  String aagentId;
  int aagentBrokerage;
  String aagentName;
  String aagentMobile;
  String bagentName;
  String bagentMobile;
  String cagentName;
  String cagentMobile;
  String fagentId;

  OrderStoreSnapshot(
      {this.id,
        this.createTime,
        this.updateTime,
        this.proxyUserId,
        this.agentId,
        this.agentLevel,
        this.storeBrokerage,
        this.storeCreateTime,
        this.storeUpdateTime,
        this.storeName,
        this.siteId,
        this.dicSiteCode,
        this.dicSiteName,
        this.dicSiteLevel,
        this.beginTime,
        this.endTime,
        this.servicePhone,
        this.address,
        this.longitude,
        this.latitude,
        this.advLink,
        this.advImg,
        this.proxyUserName,
        this.proxyUserMobile,
        this.agentName,
        this.agentMobile,
        this.chargerPrice,
        this.price,
        this.dayMax,
        this.storeId,
        this.orderId,
        this.deviceInfoId,
        this.orderSn,
        this.freeTime,
        this.cagentId,
        this.cagentBrokerage,
        this.bagentId,
        this.bagentBrokerage,
        this.aagentId,
        this.aagentBrokerage,
        this.aagentName,
        this.aagentMobile,
        this.bagentName,
        this.bagentMobile,
        this.cagentName,
        this.cagentMobile,
        this.fagentId});

  OrderStoreSnapshot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    proxyUserId = json['proxyUserId'];
    agentId = json['agentId'];
    agentLevel = json['agentLevel'];
    storeBrokerage = json['storeBrokerage'];
    storeCreateTime = json['storeCreateTime'];
    storeUpdateTime = json['storeUpdateTime'];
    storeName = json['storeName'];
    siteId = json['siteId'];
    dicSiteCode = json['dicSiteCode'];
    dicSiteName = json['dicSiteName'];
    dicSiteLevel = json['dicSiteLevel'];
    beginTime = json['beginTime'];
    endTime = json['endTime'];
    servicePhone = json['servicePhone'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    advLink = json['advLink'];
    advImg = json['advImg'];
    proxyUserName = json['proxyUserName'];
    proxyUserMobile = json['proxyUserMobile'];
    agentName = json['agentName'];
    agentMobile = json['agentMobile'];
    chargerPrice = json['chargerPrice'];
    price = json['price'];
    dayMax = json['dayMax'];
    storeId = json['storeId'];
    orderId = json['orderId'];
    deviceInfoId = json['deviceInfoId'];
    orderSn = json['orderSn'];
    freeTime = json['freeTime'];
    cagentId = json['cagentId'];
    cagentBrokerage = json['cagentBrokerage'];
    bagentId = json['bagentId'];
    bagentBrokerage = json['bagentBrokerage'];
    aagentId = json['aagentId'];
    aagentBrokerage = json['aagentBrokerage'];
    aagentName = json['aagentName'];
    aagentMobile = json['aagentMobile'];
    bagentName = json['bagentName'];
    bagentMobile = json['bagentMobile'];
    cagentName = json['cagentName'];
    cagentMobile = json['cagentMobile'];
    fagentId = json['fagentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['proxyUserId'] = this.proxyUserId;
    data['agentId'] = this.agentId;
    data['agentLevel'] = this.agentLevel;
    data['storeBrokerage'] = this.storeBrokerage;
    data['storeCreateTime'] = this.storeCreateTime;
    data['storeUpdateTime'] = this.storeUpdateTime;
    data['storeName'] = this.storeName;
    data['siteId'] = this.siteId;
    data['dicSiteCode'] = this.dicSiteCode;
    data['dicSiteName'] = this.dicSiteName;
    data['dicSiteLevel'] = this.dicSiteLevel;
    data['beginTime'] = this.beginTime;
    data['endTime'] = this.endTime;
    data['servicePhone'] = this.servicePhone;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['advLink'] = this.advLink;
    data['advImg'] = this.advImg;
    data['proxyUserName'] = this.proxyUserName;
    data['proxyUserMobile'] = this.proxyUserMobile;
    data['agentName'] = this.agentName;
    data['agentMobile'] = this.agentMobile;
    data['chargerPrice'] = this.chargerPrice;
    data['price'] = this.price;
    data['dayMax'] = this.dayMax;
    data['storeId'] = this.storeId;
    data['orderId'] = this.orderId;
    data['deviceInfoId'] = this.deviceInfoId;
    data['orderSn'] = this.orderSn;
    data['freeTime'] = this.freeTime;
    data['cagentId'] = this.cagentId;
    data['cagentBrokerage'] = this.cagentBrokerage;
    data['bagentId'] = this.bagentId;
    data['bagentBrokerage'] = this.bagentBrokerage;
    data['aagentId'] = this.aagentId;
    data['aagentBrokerage'] = this.aagentBrokerage;
    data['aagentName'] = this.aagentName;
    data['aagentMobile'] = this.aagentMobile;
    data['bagentName'] = this.bagentName;
    data['bagentMobile'] = this.bagentMobile;
    data['cagentName'] = this.cagentName;
    data['cagentMobile'] = this.cagentMobile;
    data['fagentId'] = this.fagentId;
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