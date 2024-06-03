import 'package:json_annotation/json_annotation.dart';

part 'get_customer_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetCustomer {
  int? status;
  String? message;
  List<Customer>? customers;
  int? totalCustomers;

  GetCustomer({
    this.status,
    this.message,
    this.customers,
    this.totalCustomers,
  });

  factory GetCustomer.fromJson(Map<String, dynamic> json) =>
      _$GetCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$GetCustomerToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Customer {
  int? id;
  String? name;
  String? mobile;
  String? email;
  int? age;
  String? refrenceno;
  String? occupation;
  String? address;
  DateTime? dob;
  int? height;
  int? weight;
  String? imagename;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? roleId;
  int? businessId;
  int? consultantId;
  int? registrationId;

  Customer({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.age,
    this.refrenceno,
    this.occupation,
    this.address,
    this.dob,
    this.height,
    this.weight,
    this.imagename,
    this.createdAt,
    this.updatedAt,
    this.roleId,
    this.businessId,
    this.consultantId,
    this.registrationId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
