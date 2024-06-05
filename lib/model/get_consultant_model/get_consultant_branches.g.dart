// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_consultant_branches.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConsultantBranches _$GetConsultantBranchesFromJson(
        Map<String, dynamic> json) =>
    GetConsultantBranches(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      consultant: (json['consultant'] as List<dynamic>?)
          ?.map((e) => ConsultantBranch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetConsultantBranchesToJson(
        GetConsultantBranches instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'consultant': instance.consultant?.map((e) => e.toJson()).toList(),
    };

ConsultantBranch _$ConsultantBranchFromJson(Map<String, dynamic> json) =>
    ConsultantBranch(
      cbid: (json['cbid'] as num?)?.toInt(),
      consultantId: (json['consultant_id'] as num?)?.toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      branchCode: json['branch_code'] as String?,
      businessId: (json['business_id'] as num?)?.toInt(),
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      address: json['address'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ConsultantBranchToJson(ConsultantBranch instance) =>
    <String, dynamic>{
      'cbid': instance.cbid,
      'consultant_id': instance.consultantId,
      'branch_id': instance.branchId,
      'id': instance.id,
      'branch_code': instance.branchCode,
      'business_id': instance.businessId,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'address': instance.address,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
