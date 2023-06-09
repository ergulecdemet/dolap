class ProfileModel {
  bool? status;
  String? message;
  UserProfileModel? data;
  String? token;

  ProfileModel({this.status, this.message, this.data, this.token});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? UserProfileModel.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class UserProfileModel {
  int? id;
  String? name;
  String? surname;
  int? userType;
  String? email;
  String? emailVerifiedAt;
  String? money;
  String? photo;
  String? createdAt;
  String? updatedAt;

  UserProfileModel(
      {this.id,
      this.name,
      this.surname,
      this.userType,
      this.email,
      this.emailVerifiedAt,
      this.money,
      this.photo,
      this.createdAt,
      this.updatedAt});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    userType = json['user_type'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    money = json['money'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['user_type'] = userType;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['money'] = money;
    data['photo'] = photo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
