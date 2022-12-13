class DivisionList {
  int? id;
  int? divisionId;
  String? divisionBng;
  String? divisionEng;
  int? dataCreateBy;
  String? dataCreateIp;
  int? dataUpdateBy;
  String? dataUpdateIp;
  String? createdAt;
  String? updatedAt;

  DivisionList(
      {this.id,
        this.divisionId,
        this.divisionBng,
        this.divisionEng,
        this.dataCreateBy,
        this.dataCreateIp,
        this.dataUpdateBy,
        this.dataUpdateIp,
        this.createdAt,
        this.updatedAt});

  DivisionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    divisionId = json['divisionId'];
    divisionBng = json['divisionBng'];
    divisionEng = json['divisionEng'];
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
    data['divisionBng'] = this.divisionBng;
    data['divisionEng'] = this.divisionEng;
    data['dataCreateBy'] = this.dataCreateBy;
    data['dataCreateIp'] = this.dataCreateIp;
    data['dataUpdateBy'] = this.dataUpdateBy;
    data['dataUpdateIp'] = this.dataUpdateIp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}