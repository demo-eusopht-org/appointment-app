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
      businessOwnerId: (json['business_owner_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user': instance.user?.toJson(),
      'token': instance.token,
      'business_id': instance.businessId,
      'business_owner_id': instance.businessOwnerId,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      experience: json['experience'] as String?,
      field: json['field'] as String?,
      about: json['about'] as String?,
      imageName: json['image_name'] as String?,
      userid: json['userid'] as String?,
      email: json['email'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      verified: (json['verified'] as num?)?.toInt(),
      roleId: (json['role_id'] as num?)?.toInt(),
      businessId: (json['business_id'] as num?)?.toInt(),
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'experience': instance.experience,
      'field': instance.field,
      'about': instance.about,
      'image_name': instance.imageName,
      'userid': instance.userid,
      'email': instance.email,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'phone_number': instance.phoneNumber,
      'verified': instance.verified,
      'role_id': instance.roleId,
      'business_id': instance.businessId,
    };
