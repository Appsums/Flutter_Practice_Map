class StationDetailBean {
  String msg;
  bool success;
  Result result;
  int statusCode;

  StationDetailBean({this.msg, this.success, this.result, this.statusCode});

  StationDetailBean.fromJson(Map<String, dynamic> json) {
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
  StoreInfoDto storeInfoDto;
  List<String> storePowerBankStatuses;
  List<String> storeChargeStatuses;

  Result(
      {this.storeInfoDto,
        this.storePowerBankStatuses,
        this.storeChargeStatuses});

  Result.fromJson(Map<String, dynamic> json) {
    storeInfoDto = json['storeInfoDto'] != null
        ? new StoreInfoDto.fromJson(json['storeInfoDto'])
        : null;
    storePowerBankStatuses = json['storePowerBankStatuses'].cast<String>();
    storeChargeStatuses = json['storeChargeStatuses'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storeInfoDto != null) {
      data['storeInfoDto'] = this.storeInfoDto.toJson();
    }
    data['storePowerBankStatuses'] = this.storePowerBankStatuses;
    data['storeChargeStatuses'] = this.storeChargeStatuses;
    return data;
  }
}

class StoreInfoDto {
  int storeBrokerage;
  String agentName;
  String agentId;
  String storeId;
  String storeInfoId;
  String storeName;
  String siteType;
  String subSite;
  String siteId;
  int deviceCount;
  String address;
  String name;
  int totalAmount;
  String beginTime;
  String endTime;
  String servicePhone;
  String mobile;
  double longitude;
  double latitude;
  int chargerCount;
  int powerBankCount;
  String platformAdvImg;
  String platformAdvLink;
  String updateTime;
  String createTime;
  String advImg;
  String advLink;
  int total;
  int unNum;

  StoreInfoDto(
      {this.storeBrokerage,
        this.agentName,
        this.agentId,
        this.storeId,
        this.storeInfoId,
        this.storeName,
        this.siteType,
        this.subSite,
        this.siteId,
        this.deviceCount,
        this.address,
        this.name,
        this.totalAmount,
        this.beginTime,
        this.endTime,
        this.servicePhone,
        this.mobile,
        this.longitude,
        this.latitude,
        this.chargerCount,
        this.powerBankCount,
        this.platformAdvImg,
        this.platformAdvLink,
        this.updateTime,
        this.createTime,
        this.advImg,
        this.advLink,
        this.total,
        this.unNum});

  StoreInfoDto.fromJson(Map<String, dynamic> json) {
    storeBrokerage = json['storeBrokerage'];
    agentName = json['agentName'];
    agentId = json['agentId'];
    storeId = json['storeId'];
    storeInfoId = json['storeInfoId'];
    storeName = json['storeName'];
    siteType = json['siteType'];
    subSite = json['subSite'];
    siteId = json['siteId'];
    deviceCount = json['deviceCount'];
    address = json['address'];
    name = json['name'];
    totalAmount = json['totalAmount'];
    beginTime = json['beginTime'];
    endTime = json['endTime'];
    servicePhone = json['servicePhone'];
    mobile = json['mobile'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    chargerCount = json['chargerCount'];
    powerBankCount = json['powerBankCount'];
    platformAdvImg = json['platformAdvImg'];
    platformAdvLink = json['platformAdvLink'];
    updateTime = json['updateTime'];
    createTime = json['createTime'];
    advImg = json['advImg'];
    advLink = json['advLink'];
    total = json['total'];
    unNum = json['unNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeBrokerage'] = this.storeBrokerage;
    data['agentName'] = this.agentName;
    data['agentId'] = this.agentId;
    data['storeId'] = this.storeId;
    data['storeInfoId'] = this.storeInfoId;
    data['storeName'] = this.storeName;
    data['siteType'] = this.siteType;
    data['subSite'] = this.subSite;
    data['siteId'] = this.siteId;
    data['deviceCount'] = this.deviceCount;
    data['address'] = this.address;
    data['name'] = this.name;
    data['totalAmount'] = this.totalAmount;
    data['beginTime'] = this.beginTime;
    data['endTime'] = this.endTime;
    data['servicePhone'] = this.servicePhone;
    data['mobile'] = this.mobile;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['chargerCount'] = this.chargerCount;
    data['powerBankCount'] = this.powerBankCount;
    data['platformAdvImg'] = this.platformAdvImg;
    data['platformAdvLink'] = this.platformAdvLink;
    data['updateTime'] = this.updateTime;
    data['createTime'] = this.createTime;
    data['advImg'] = this.advImg;
    data['advLink'] = this.advLink;
    data['total'] = this.total;
    data['unNum'] = this.unNum;
    return data;
  }
}
