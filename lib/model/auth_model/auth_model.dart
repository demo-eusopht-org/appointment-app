import 'package:json_annotation/json_annotation.dart';
part 'auth_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AuthResponse {
  int? status;
  String? message;
  User? user;
  String? token;
  int? businessId;
  int? businessOwnerId;

  AuthResponse({
    this.status,
    this.message,
    this.user,
    this.token,
    this.businessId,
    this.businessOwnerId,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class User {
  int? id;
  String? name;
  String? experience; 
  String? field;
  String? about;
  String? imageName;
  String? userid;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? phoneNumber;

  int? verified;
  int? roleId;
  int? businessId;

  User({
    this.id,
    this.name,
    this.experience,
    this.field,
    this.about,
    this.imageName,
    this.userid,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.verified,
    this.roleId,
    this.businessId,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
