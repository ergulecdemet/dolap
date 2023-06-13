class PaymentModel {
  bool? status;
  String? message;
  UserPaymentModel? data;

  PaymentModel({this.status, this.message, this.data});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? UserPaymentModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserPaymentModel {
  int? id;
  String? name;
  String? description;
  int? price;
  String? photo;
  int? categoryId;
  int? userId;
  String? buyDate;
  String? buyerId;
  String? createdAt;
  String? updatedAt;

  UserPaymentModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.photo,
      this.categoryId,
      this.userId,
      this.buyDate,
      this.buyerId,
      this.createdAt,
      this.updatedAt});

  UserPaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    photo = json['photo'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    buyDate = json['buy_date'];
    buyerId = json['buyer_id'];
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
    data['buy_date'] = buyDate;
    data['buyer_id'] = buyerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
