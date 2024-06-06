import 'package:json_annotation/json_annotation.dart';

part 'get_consultant_schedule.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetConsultantSchedule {
  int? status;
  String? message;
  int? total;
  List<ConsultantSchedule>? consultantSchedule; // Use a more descriptive name

  GetConsultantSchedule({
    this.status,
    this.message,
    this.total,
    this.consultantSchedule,
  });

  factory GetConsultantSchedule.fromJson(Map<String, dynamic> json) =>
      _$GetConsultantScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$GetConsultantScheduleToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ConsultantSchedule {
  int? cbid;
  int? branchId;
  int? scheduledId;
  String? startTime;
  String? endTime;
  String? day;

  ConsultantSchedule({
    this.cbid,
    this.branchId,
    this.scheduledId,
    this.startTime,
    this.endTime,
    this.day,
  });

  factory ConsultantSchedule.fromJson(Map<String, dynamic> json) =>
      _$ConsultantScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultantScheduleToJson(this);
}
