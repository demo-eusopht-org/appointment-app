import 'package:json_annotation/json_annotation.dart';

part 'get_business_branch.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetBranch {
  int? status;
  String? message;
  List<Branch>? businessBranches;

  GetBranch({
    this.status,
    this.message,
    required this.businessBranches,
  });

  factory GetBranch.fromJson(Map<String, dynamic> json) =>
      _$GetBranchFromJson(json);

  Map<String, dynamic> toJson() => _$GetBranchToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Branch {
  int? id;
  String? branchCode;
  int? businessId;
  String? startTime;
  String? endTime;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;

  Branch({
    this.id,
    this.branchCode,
    this.businessId,
    this.startTime,
    this.endTime,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}
