class NoticeModel {
  bool? status;
  String? msg;
  List<Data>? data;

  NoticeModel({this.status, this.msg, this.data});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? image;
  String? path;
  String? heading;
  String? description;
  String? publishingDate;
  String? pdfFile;
  String? pdfFileWithExtension;
  int? status;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.image,
      this.path,
      this.heading,
      this.description,
      this.publishingDate,
      this.pdfFile,
      this.pdfFileWithExtension,
      this.status,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    path = json['path'];
    heading = json['heading'];
    description = json['description'];
    publishingDate = json['publishingDate'];
    pdfFile = json['pdfFile'];
    pdfFileWithExtension = json['pdfFileWithExtension'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['path'] = this.path;
    data['heading'] = this.heading;
    data['description'] = this.description;
    data['publishingDate'] = this.publishingDate;
    data['pdfFile'] = this.pdfFile;
    data['pdfFileWithExtension'] = this.pdfFileWithExtension;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
