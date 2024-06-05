// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_business_branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBranch _$GetBranchFromJson(Map<String, dynamic> json) => GetBranch(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      businessBranches: (json['business_branches'] as List<dynamic>?)
          ?.map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBranchToJson(GetBranch instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'business_branches': instance.businessBranches,
    };

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
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

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'id': instance.id,
      'branch_code': instance.branchCode,
      'business_id': instance.businessId,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'address': instance.address,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
