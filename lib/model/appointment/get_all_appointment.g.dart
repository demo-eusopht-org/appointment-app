// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllAppointments _$GetAllAppointmentsFromJson(Map<String, dynamic> json) =>
    GetAllAppointments(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      appointments: (json['appointments'] as List<dynamic>?)
          ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAppointments: (json['total_appointments'] as num?)?.toInt(),
      currentMonthAppointments:
          (json['current_month_appointments'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetAllAppointmentsToJson(GetAllAppointments instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'appointments': instance.appointments?.map((e) => e.toJson()).toList(),
      'total_appointments': instance.totalAppointments,
      'current_month_appointments': instance.currentMonthAppointments,
    };

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      appointmentId: (json['appointment_id'] as num?)?.toInt(),
      customerId: (json['customer_id'] as num?)?.toInt(),
      consultantId: (json['consultant_id'] as num?)?.toInt(),
      uidAppointment: json['uid_appointment'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      appointmentDate: json['appointment_date'] == null
          ? null
          : DateTime.parse(json['appointment_date'] as String),
      scheduleTime: json['schedule_time'] as String?,
      businessId: (json['business_id'] as num?)?.toInt(),
      appointmentNote: json['appointment_note'] as String?,
      branchId: json['branch_id'] as String?,
      start: Appointment.dateFromJson((json['start'] as num?)?.toInt()),
      end: Appointment.dateFromJson((json['end'] as num?)?.toInt()),
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'appointment_id': instance.appointmentId,
      'customer_id': instance.customerId,
      'consultant_id': instance.consultantId,
      'uid_appointment': instance.uidAppointment,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'appointment_date': instance.appointmentDate?.toIso8601String(),
      'schedule_time': instance.scheduleTime,
      'business_id': instance.businessId,
      'appointment_note': instance.appointmentNote,
      'branch_id': instance.branchId,
      'start': Appointment.dateToJson(instance.start),
      'end': Appointment.dateToJson(instance.end),
    };
