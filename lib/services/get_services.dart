import 'dart:developer';

import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/model/get_business/get_business_branch.dart';
import 'package:appointment_management/model/get_business/get_business_data.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_customer_model/get_customer_model.dart';
import 'package:appointment_management/model/get_services/get_services_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';

class GetLocalData {
  static List<Service> getServices() {
    List<Map<String, dynamic>>? tempServices =
        locator<LocalStorageService>().getData(key: 'services');
    if (tempServices != null) {
      return tempServices.map((e) => Service.fromJson(e)).toList();
    }
    return [];
  }

  static List<Business> getBusiness() {
    List<Map<String, dynamic>>? tempBusiness =
        locator<LocalStorageService>().getData(key: 'businessData');
    if (tempBusiness != null) {
      return tempBusiness.map((e) => Business.fromJson(e)).toList();
    }
    return [];
  }

  static List<Consultant> getConsultants() {
    List<Map<String, dynamic>>? tempServices =
        locator<LocalStorageService>().getData(key: 'consultants');
    if (tempServices != null) {
      return tempServices.map((e) => Consultant.fromJson(e)).toList();
    }
    return [];
  }

  static List<Branch> getBranches() {
    List<Map<String, dynamic>>? tempServices =
        locator<LocalStorageService>().getData(key: 'branches');
    if (tempServices != null) {
      return tempServices.map((e) => Branch.fromJson(e)).toList();
    }
    return [];
  }

  static List<Customer> getCustomers() {
    List<Map<String, dynamic>>? tempServices =
        locator<LocalStorageService>().getData(key: 'customers');

    if (tempServices != null) {
      return tempServices.map((e) => Customer.fromJson(e)).toList();
    }
    return [];
  }

  static User getUser() {
    final user = locator<LocalStorageService>().getData(key: 'user');
    final userData = user['user'];

    return User(
        name: userData['username'],
        email: userData['email'],
        createdAt: userData['created_at'],
        updatedAt: userData['updated_at'],
        id: userData['id'],
        verified: userData['verified'],
        roleId: userData['role_id']);
  }
}
