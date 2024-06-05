import 'package:appointment_management/model/get_business_branch/get_business_branch.dart';
import 'package:appointment_management/model/get_consultant_model/get_consultant_model.dart';
import 'package:appointment_management/model/get_services/get_services_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';

class GetLocalData {
  static List<Service> getServices() {
    List<Map<String, dynamic>> tempServices =
        locator<LocalStorageService>().getData(key: 'services');
    return tempServices.map((e) => Service.fromJson(e)).toList();
  }

  static List<Consultant> getConsultants() {
    List<Map<String, dynamic>> tempServices =
        locator<LocalStorageService>().getData(key: 'consultants');
    return tempServices.map((e) => Consultant.fromJson(e)).toList();
  }

  static List<Branch> getBranches() {
    List<Map<String, dynamic>> tempServices =
        locator<LocalStorageService>().getData(key: 'branches');
    return tempServices.map((e) => Branch.fromJson(e)).toList();
  }
}
