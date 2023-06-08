class ProductModel {
  bool? status;
  String? message;
  List<UserProductModel>? data;

  ProductModel({this.status, this.message, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserProductModel>[];
      json['data'].forEach((v) {
        data!.add(UserProductModel.fromJson(v));
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

class UserProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  String? photo;
  int? categoryId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  UserProductModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.photo,
      this.categoryId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  UserProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    photo = json['photo'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['photo'] = photo;
    data['category_id'] = categoryId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
