// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_consultant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConsultant _$GetConsultantFromJson(Map<String, dynamic> json) =>
    GetConsultant(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      consultants: (json['consultants'] as List<dynamic>)
          .map((e) => Consultant.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalConsultants: (json['total_consultants'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetConsultantToJson(GetConsultant instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'consultants': instance.consultants,
      'total_consultants': instance.totalConsultants,
    };

Consultant _$ConsultantFromJson(Map<String, dynamic> json) => Consultant(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      field: json['field'] as String?,
      experience: json['experience'] as String?,
      about: json['about'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      imageName: json['image_name'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      roleId: (json['role_id'] as num?)?.toInt(),
      businessId: (json['business_id'] as num?)?.toInt(),
      password: json['password'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ConsultantToJson(Consultant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'field': instance.field,
      'experience': instance.experience,
      'about': instance.about,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image_name': instance.imageName,
      'user_id': instance.userId,
      'role_id': instance.roleId,
      'business_id': instance.businessId,
      'password': instance.password,
      'email': instance.email,
    };
