import 'package:json_annotation/json_annotation.dart';

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
class Appointment {
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
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
