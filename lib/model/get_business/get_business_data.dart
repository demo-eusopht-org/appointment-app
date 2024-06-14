import 'package:json_annotation/json_annotation.dart';

part 'get_business_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetBusinessData {
  int? status;
  String? message;
  List<Business>? business;

  GetBusinessData({
    this.status,
    this.message,
    required this.business,
  });

  factory GetBusinessData.fromJson(Map<String, dynamic> json) =>
      _$GetBusinessDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetBusinessDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Business {
  int? id;
  String? name;
  String? profession;
  String? completeAddress;
  String? phoneNumber;
  String? language;
  String? email;
  String? website;
  String? location;
  int? fees;
  String? whatsappNote;
  String? footNote;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  String? startTime;
  String? endTime;
  String? imageName;

  Business({
    this.id,
    this.name,
    this.profession,
    this.completeAddress,
    this.phoneNumber,
    this.language,
    this.email,
    this.website,
    this.location,
    this.fees,
    this.whatsappNote,
    this.footNote,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.startTime,
    this.endTime,
    this.imageName,
  });

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}
