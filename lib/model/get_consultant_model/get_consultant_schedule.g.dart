// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_consultant_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConsultantSchedule _$GetConsultantScheduleFromJson(
        Map<String, dynamic> json) =>
    GetConsultantSchedule(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      total: (json['total'] as num?)?.toInt(),
      consultantSchedule: (json['consultant_schedule'] as List<dynamic>?)
          ?.map((e) => ConsultantSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetConsultantScheduleToJson(
        GetConsultantSchedule instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'total': instance.total,
      'consultant_schedule':
          instance.consultantSchedule?.map((e) => e.toJson()).toList(),
    };

ConsultantSchedule _$ConsultantScheduleFromJson(Map<String, dynamic> json) =>
    ConsultantSchedule(
      cbid: (json['cbid'] as num?)?.toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      scheduledId: (json['scheduled_id'] as num?)?.toInt(),
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      day: json['day'] as String?,
    );

Map<String, dynamic> _$ConsultantScheduleToJson(ConsultantSchedule instance) =>
    <String, dynamic>{
      'cbid': instance.cbid,
      'branch_id': instance.branchId,
      'scheduled_id': instance.scheduledId,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'day': instance.day,
    };
