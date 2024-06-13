import 'dart:developer';

import 'package:appointment_management/src/utils/extensions.dart';
import 'package:appointment_management/src/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timetable/timetable.dart';

part 'get_all_appointment.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetAllAppointments {
  int? status;
  String? message;
  List<Appointment>? appointments;
  int? totalAppointments;
  int? currentMonthAppointments;

  GetAllAppointments({
    this.status,
    this.message,
    this.appointments,
    this.totalAppointments,
    this.currentMonthAppointments,
  });

  factory GetAllAppointments.fromJson(Map<String, dynamic> json) =>
      _$GetAllAppointmentsFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllAppointmentsToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Appointment extends Event {
  int? appointmentId;
  int? customerId;
  int? consultantId;
  String? uidAppointment;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? appointmentDate;
  String? scheduleTime;
  int? businessId;
  String? appointmentNote;
  String? branchId;

  @override
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  // ignore: overridden_fields
  DateTime start;

  @override
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  // ignore: overridden_fields
  DateTime end;

  Appointment({
    this.appointmentId,
    this.customerId,
    this.consultantId,
    this.uidAppointment,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.appointmentDate,
    this.scheduleTime,
    this.businessId,
    this.appointmentNote,
    this.branchId,
    required this.start,
    required this.end,
  }) : super(start: start, end: end) {
    if (appointmentDate != null && scheduleTime != null) {
      final startTime = utils.mergeTime(appointmentDate!, scheduleTime!);
      start = startTime;
      end = startTime.add(const Duration(minutes: 30));
    }
  }

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  static DateTime dateFromJson(int? timestamp) {
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    } else {
      return DateTime.now();
    }
  }

  static int dateToJson(DateTime? dateTime) {
    if (dateTime != null) {
      return dateTime.millisecondsSinceEpoch;
    } else {
      return DateTime.now().millisecondsSinceEpoch;
    }
  }
}
