import 'package:json_annotation/json_annotation.dart';
part 'auth_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthResponse {
  int? status;
  String? message;
  User? user;
  String? token;
  String? businessId;

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
  String username;
  String email;
  String createdAt;
  String updatedAt;
  int id;
  int verified;
  int roleId;

  User({
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.verified,
    required this.roleId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
