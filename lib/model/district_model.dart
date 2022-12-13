class DistrictModel {
  int? id;
  String? districtId;
  String? divisionId;
  String? districtBng;
  String? districtEng;
  String? dataCreateBy;
  String? dataCreateIp;
  int? dataUpdateBy;
  String? dataUpdateIp;
  String? createdAt;
  String? updatedAt;

  DistrictModel(
      {this.id,
        this.districtId,
        this.divisionId,
        this.districtBng,
        this.districtEng,
        this.dataCreateBy,
        this.dataCreateIp,
        this.dataUpdateBy,
        this.dataUpdateIp,
        this.createdAt,
        this.updatedAt});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['districtId'];
    divisionId = json['divisionId'];
    districtBng = json['districtBng'];
    districtEng = json['districtEng'];
    dataCreateBy = json['dataCreateBy'];
    dataCreateIp = json['dataCreateIp'];
    dataUpdateBy = json['dataUpdateBy'];
    dataUpdateIp = json['dataUpdateIp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['districtId'] = this.districtId;
    data['divisionId'] = this.divisionId;
    data['districtBng'] = this.districtBng;
    data['districtEng'] = this.districtEng;
    data['dataCreateBy'] = this.dataCreateBy;
    data['dataCreateIp'] = this.dataCreateIp;
    data['dataUpdateBy'] = this.dataUpdateBy;
    data['dataUpdateIp'] = this.dataUpdateIp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}