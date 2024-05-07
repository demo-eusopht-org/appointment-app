// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericModel _$GenericModelFromJson(Map<String, dynamic> json) => GenericModel(
      message: json['message'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$GenericModelToJson(GenericModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
