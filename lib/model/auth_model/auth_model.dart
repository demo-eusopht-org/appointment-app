import 'package:json_annotation/json_annotation.dart';
part 'auth_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AuthResponse {
  int? status;
  String? message;
  User? user;
  String? token;
  int? businessId;

  AuthResponse({
    this.status,
    this.message,
    this.user,
    this.token,
    this.businessId,
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
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? id;
  int? verified;
  int? roleId;

  User({
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.verified,
    this.roleId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
