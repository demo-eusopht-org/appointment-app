import 'package:json_annotation/json_annotation.dart';

part 'get_consultant_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetConsultant {
  int? status;
  String? message;
  List<Consultant> consultants;
  int? totalConsultants;

  GetConsultant({
    this.status,
    this.message,
    required this.consultants,
    this.totalConsultants,
  });

  factory GetConsultant.fromJson(Map<String, dynamic> json) =>
      _$GetConsultantFromJson(json);

  Map<String, dynamic> toJson() => _$GetConsultantToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Consultant {
  int? id;
  String? name;
  String? field;
  int? experience;
  String? about;
  String? createdAt;
  String? updatedAt;
  String? imagename;
  int? userId;
  int? roleId;
  int? businessId;
  String? password;
  String? email;

  Consultant({
    this.id,
    this.name,
    this.field,
    this.experience,
    this.about,
    this.createdAt,
    this.updatedAt,
    this.imagename,
    this.userId,
    this.roleId,
    this.businessId,
    this.password,
    this.email,
  });

  factory Consultant.fromJson(Map<String, dynamic> json) =>
      _$ConsultantFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultantToJson(this);
}
