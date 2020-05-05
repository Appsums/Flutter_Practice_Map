class StoreIndexBean {
  String msg;
  bool success;
  List<Result> result;
  int statusCode;

  StoreIndexBean({this.msg, this.success, this.result, this.statusCode});

  StoreIndexBean.fromJson(Map<String, dynamic> json) {
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
  String storeName;
  String storeId;
  String storeInfoId;
  double longitude;
  double latitude;

  Result(
      {this.storeName,
        this.storeId,
        this.storeInfoId,
        this.longitude,
        this.latitude});

  Result.fromJson(Map<String, dynamic> json) {
    storeName = json['storeName'];
    storeId = json['storeId'];
    storeInfoId = json['storeInfoId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeName'] = this.storeName;
    data['storeId'] = this.storeId;
    data['storeInfoId'] = this.storeInfoId;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
