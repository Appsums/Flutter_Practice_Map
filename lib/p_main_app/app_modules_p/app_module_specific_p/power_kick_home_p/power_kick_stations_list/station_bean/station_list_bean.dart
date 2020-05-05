class StationList {
  String msg;
  bool success;
  Result result;
  int statusCode;

  StationList({this.msg, this.success, this.result, this.statusCode});

  StationList.fromJson(Map<String, dynamic> json) {
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
  String id;
  String name;
  String startTime;
  String endTime;
  String img;
  int total;
  int useNum;
  int unUse;
  int dis;
  String link;
  double longitude;
  double latitude;
  String address;

  Records(
      {this.id,
        this.name,
        this.startTime,
        this.endTime,
        this.img,
        this.total,
        this.useNum,
        this.unUse,
        this.dis,
        this.link,
        this.longitude,
        this.latitude,
        this.address});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    img = json['img'];
    total = json['total'];
    useNum = json['useNum'];
    unUse = json['unUse'];
    dis = json['dis'];
    link = json['link'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['img'] = this.img;
    data['total'] = this.total;
    data['useNum'] = this.useNum;
    data['unUse'] = this.unUse;
    data['dis'] = this.dis;
    data['link'] = this.link;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['address'] = this.address;
    return data;
  }
}
