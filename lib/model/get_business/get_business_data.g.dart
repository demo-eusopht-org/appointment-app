// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_business_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBusinessData _$GetBusinessDataFromJson(Map<String, dynamic> json) =>
    GetBusinessData(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      business: (json['business'] as List<dynamic>?)
          ?.map((e) => Business.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBusinessDataToJson(GetBusinessData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'business': instance.business,
    };

Business _$BusinessFromJson(Map<String, dynamic> json) => Business(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      profession: json['profession'] as String?,
      completeAddress: json['complete_address'] as String?,
      phoneNumber: json['phone_number'] as String?,
      language: json['language'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      location: json['location'] as String?,
      fees: (json['fees'] as num?)?.toInt(),
      whatsappNote: json['whatsapp_note'] as String?,
      footNote: json['foot_note'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      userId: (json['user_id'] as num?)?.toInt(),
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      imagename: json['imagename'] as String?,
    );

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profession': instance.profession,
      'complete_address': instance.completeAddress,
      'phone_number': instance.phoneNumber,
      'language': instance.language,
      'email': instance.email,
      'website': instance.website,
      'location': instance.location,
      'fees': instance.fees,
      'whatsapp_note': instance.whatsappNote,
      'foot_note': instance.footNote,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user_id': instance.userId,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'imagename': instance.imagename,
    };
