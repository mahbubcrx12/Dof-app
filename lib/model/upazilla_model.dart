class UpazillaModel {
  int? id;
  int? divisionId;
  int? districtId;
  int? upazilaId;
  String? upazilaBng;
  String? upazilaEng;
  Null? dataCreateBy;
  Null? dataCreateIp;
  int? dataUpdateBy;
  String? dataUpdateIp;
  Null? createdAt;
  Null? updatedAt;

  UpazillaModel(
      {this.id,
        this.divisionId,
        this.districtId,
        this.upazilaId,
        this.upazilaBng,
        this.upazilaEng,
        this.dataCreateBy,
        this.dataCreateIp,
        this.dataUpdateBy,
        this.dataUpdateIp,
        this.createdAt,
        this.updatedAt});

  UpazillaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    divisionId = json['divisionId'];
    districtId = json['districtId'];
    upazilaId = json['upazilaId'];
    upazilaBng = json['upazilaBng'];
    upazilaEng = json['upazilaEng'];
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
    data['divisionId'] = this.divisionId;
    data['districtId'] = this.districtId;
    data['upazilaId'] = this.upazilaId;
    data['upazilaBng'] = this.upazilaBng;
    data['upazilaEng'] = this.upazilaEng;
    data['dataCreateBy'] = this.dataCreateBy;
    data['dataCreateIp'] = this.dataCreateIp;
    data['dataUpdateBy'] = this.dataUpdateBy;
    data['dataUpdateIp'] = this.dataUpdateIp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}