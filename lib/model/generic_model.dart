import 'package:json_annotation/json_annotation.dart';
part 'generic_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class GenericModel {
  String message;
  int status;
  GenericModel({
    required this.message,
    required this.status,
  });

  factory GenericModel.fromJson(Map<String, dynamic> json) {
    return _$GenericModelFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$GenericModelToJson(this);
  }
}
