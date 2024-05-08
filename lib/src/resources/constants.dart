import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';

class Constants {
  // static const String baseUrl = 'https://appointment.eusopht.com/apis';
  static const String baseUrl = 'http://192.168.100.121:3000';

  static const String onBoardingSignUp = '${baseUrl}/onboarding/sign-up';

  static const String addConsultant = '${baseUrl}/consultant/add-consultant';
  static const String addCustomer = '${baseUrl}/customer/add-customer';
   

  static const String getBusiness =
      '$baseUrl/consultant/get-consultant-business-id/?business_id=';

  static const String consultantImageBaseUrl =
      '${baseUrl}/consultant-image/?imageName=';
}
