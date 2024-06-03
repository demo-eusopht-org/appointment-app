// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServices _$GetServicesFromJson(Map<String, dynamic> json) => GetServices(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetServicesToJson(GetServices instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'services': instance.services?.map((e) => e.toJson()).toList(),
    };

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: (json['id'] as num?)?.toInt(),
      serviceName: json['service_name'] as String?,
      price: (json['price'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      businessId: (json['business_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'service_name': instance.serviceName,
      'price': instance.price,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'business_id': instance.businessId,
    };
