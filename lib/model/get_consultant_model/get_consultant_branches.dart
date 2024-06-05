import 'package:json_annotation/json_annotation.dart';

part 'get_consultant_branches.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetConsultantBranches {
  int? status;
  String? message;
  List<ConsultantBranch>? consultant; // Use a more descriptive name

  GetConsultantBranches({
    this.status,
    this.message,
    this.consultant,
  });

  factory GetConsultantBranches.fromJson(Map<String, dynamic> json) =>
      _$GetConsultantBranchesFromJson(json);

  Map<String, dynamic> toJson() => _$GetConsultantBranchesToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ConsultantBranch {
  int? cbid;
  int? consultantId;
  int? branchId;
  int? id;

  String? branchCode;
  int? businessId;
  String? startTime;
  String? endTime;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;

  ConsultantBranch({
    this.cbid,
    this.consultantId,
    this.branchId,
    this.id,
    this.branchCode,
    this.businessId,
    this.startTime,
    this.endTime,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory ConsultantBranch.fromJson(Map<String, dynamic> json) =>
      _$ConsultantBranchFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultantBranchToJson(this);
}
