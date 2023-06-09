class MyCategoryGetModel {
  bool? status;
  String? message;
  List<MyCatgeoryDataModel>? data;

  MyCategoryGetModel({this.status, this.message, this.data});

  MyCategoryGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyCatgeoryDataModel>[];
      json['data'].forEach((v) {
        data!.add(MyCatgeoryDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyCatgeoryDataModel {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  MyCatgeoryDataModel(
      {this.id, this.name, this.description, this.createdAt, this.updatedAt});

  MyCatgeoryDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
