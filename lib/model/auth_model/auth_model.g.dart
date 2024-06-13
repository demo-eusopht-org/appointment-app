// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
      businessId: (json['business_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user': instance.user?.toJson(),
      'token': instance.token,
      'business_id': instance.businessId,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      email: json['email'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
      verified: (json['verified'] as num?)?.toInt(),
      roleId: (json['role_id'] as num?)?.toInt(),
      businessId: (json['business_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'id': instance.id,
      'verified': instance.verified,
      'role_id': instance.roleId,
      'business_id': instance.businessId,
    };
