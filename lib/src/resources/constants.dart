import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';

class Constants {
  static const String baseUrl = 'https://appointment.eusopht.com/apis';
  // static const String baseUrl = 'http://192.168.100.121:3000';

  static const String onBoardingSignUp = '${baseUrl}/onboarding/sign-up';

  static const String addConsultant = '${baseUrl}/consultant/add-consultant';
  static const String addCustomer = '${baseUrl}/customer/add-customer';

  static const String getCustomers =
      '$baseUrl/customer/business-patients/?business_id=';

  static const String getBusiness =
      '$baseUrl/consultant/get-consultant-business-id/?business_id=';
  static const String getBusinessBranch =
      '$baseUrl/onboarding/get-business-branches?business_id=';

  static const String getService =
      '$baseUrl/onboarding/get-services?business_id=';
  static const String deleteService = '$baseUrl/onboarding/delete-service';

  static const String consultantImageBaseUrl =
      '$baseUrl/consultant-image/?imageName=';
  static const String getConsultantBranches =
      '$baseUrl/consultant/get-consultant-branches?consultant_id=';
  static const String getConsultantSchedule =
      '$baseUrl/consultant/get-consultant-shedule?consultant_id=';
      static const String getAllAppointments =
      '$baseUrl/onboarding/get-business-appointments?business_id=';
      
}
