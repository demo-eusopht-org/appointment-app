// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCustomer _$GetCustomerFromJson(Map<String, dynamic> json) => GetCustomer(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      customers: (json['customers'] as List<dynamic>?)
          ?.map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCustomers: (json['total_customers'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetCustomerToJson(GetCustomer instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'customers': instance.customers?.map((e) => e.toJson()).toList(),
      'total_customers': instance.totalCustomers,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      age: (json['age'] as num?)?.toInt(),
      refrenceno: json['refrenceno'] as String?,
      occupation: json['occupation'] as String?,
      address: json['address'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      height: (json['height'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      imagename: json['imagename'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      roleId: (json['role_id'] as num?)?.toInt(),
      businessId: (json['business_id'] as num?)?.toInt(),
      consultantId: (json['consultant_id'] as num?)?.toInt(),
      registrationId: json['registration_id'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'age': instance.age,
      'refrenceno': instance.refrenceno,
      'occupation': instance.occupation,
      'address': instance.address,
      'dob': instance.dob?.toIso8601String(),
      'height': instance.height,
      'weight': instance.weight,
      'imagename': instance.imagename,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'role_id': instance.roleId,
      'business_id': instance.businessId,
      'consultant_id': instance.consultantId,
      'registration_id': instance.registrationId,
    };
