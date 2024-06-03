import 'package:json_annotation/json_annotation.dart';

part 'get_services_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetServices {
  int? status;
  String? message;
  List<Service>? services;

  GetServices({
    this.status,
    this.message,
    this.services,
  });

  factory GetServices.fromJson(Map<String, dynamic> json) =>
      _$GetServicesFromJson(json);

  Map<String, dynamic> toJson() => _$GetServicesToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Service {
  int? id;
  String? serviceName;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? businessId;

  Service({
    this.id,
    this.serviceName,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.businessId,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
