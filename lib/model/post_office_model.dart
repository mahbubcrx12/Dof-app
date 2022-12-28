class PostOfficeModel {
  int? id;
  int? postId;
  int? divisionId;
  int? districtId;
  int? upazilaId;
  int? municipalityId;
  int? unionId;
  String? postOfficeEnglish;
  String? postOfficeBangla;
  String? dataEntryBy;
  String? dataEntryIp;
  String? dataUpdateBy;
  String? dataUpdateIp;
  String? createdAt;
  String? updatedAt;

  PostOfficeModel(
      {this.id,
        this.postId,
        this.divisionId,
        this.districtId,
        this.upazilaId,
        this.municipalityId,
        this.unionId,
        this.postOfficeEnglish,
        this.postOfficeBangla,
        this.dataEntryBy,
        this.dataEntryIp,
        this.dataUpdateBy,
        this.dataUpdateIp,
        this.createdAt,
        this.updatedAt});

  PostOfficeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    divisionId = json['divisionId'];
    districtId = json['districtId'];
    upazilaId = json['upazilaId'];
    municipalityId = json['municipalityId'];
    unionId = json['unionId'];
    postOfficeEnglish = json['postOfficeEnglish'];
    postOfficeBangla = json['postOfficeBangla'];
    dataEntryBy = json['dataEntryBy'];
    dataEntryIp = json['dataEntryIp'];
    dataUpdateBy = json['dataUpdateBy'];
    dataUpdateIp = json['dataUpdateIp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['divisionId'] = this.divisionId;
    data['districtId'] = this.districtId;
    data['upazilaId'] = this.upazilaId;
    data['municipalityId'] = this.municipalityId;
    data['unionId'] = this.unionId;
    data['postOfficeEnglish'] = this.postOfficeEnglish;
    data['postOfficeBangla'] = this.postOfficeBangla;
    data['dataEntryBy'] = this.dataEntryBy;
    data['dataEntryIp'] = this.dataEntryIp;
    data['dataUpdateBy'] = this.dataUpdateBy;
    data['dataUpdateIp'] = this.dataUpdateIp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}