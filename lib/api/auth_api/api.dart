import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/Consultant%20Branch/create_branch.dart';
import 'package:appointment_management/src/views/Verify%20Email/verify_email.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;
  @POST('/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);
  @POST('/sign-up')
  Future<AuthResponse> signUp(@Body() Map<String, dynamic> body);
  @POST('/onboarding/add-service')
  Future<dynamic> createService(@Body() Map<String, dynamic> body);
  @DELETE('/onboarding/delete-service')
  Future<dynamic> deleteService(@Body() Map<String, dynamic> body);
  @POST('/onboarding/edit-service')
  Future<dynamic> updateService(@Body() Map<String, dynamic> body);
  @POST('/onboarding/add-branches')
  Future<dynamic> createBranch(@Body() Map<String, dynamic> body);
  @POST('/consultant/assign-consultant')
  Future<dynamic> assignBranch(@Body() Map<String, dynamic> body);
  @POST('/consultant/assign-consultant-shedule')
  Future<dynamic> assignConsultantBranchSchedule(
      @Body() Map<String, dynamic> body);
  @POST('/customer/create-appointment')
  Future<dynamic> createAppointment(@Body() Map<String, dynamic> body);
  @POST('/otp/regenerate-otp')
  Future<dynamic> sendOtp(@Body() Map<String, dynamic> body);
  @POST('/otp/verify-otp')
  Future<dynamic> verifyOtp(@Body() Map<String, dynamic> body);
  @POST('/forget-password')
  Future<dynamic> forgotPassword(@Body() Map<String, dynamic> body);
  @POST('/verif-otp-resetpassword')
  Future<dynamic> verifyOtpResetPass(@Body() Map<String, dynamic> body);
  @POST('/reset-password')
  Future<dynamic> resetPassword(@Body() Map<String, dynamic> body);
  @POST('/update-password')
  Future<dynamic> updatePassword(@Body() Map<String, dynamic> body);
  @POST('/customer/update-appointment')
  Future<dynamic> updateAppointment(@Body() Map<String, dynamic> body);
  @POST('/customer/reshedule-appointment')
  Future<dynamic> reScheduleAppointment(@Body() Map<String, dynamic> body);
  @POST('/consultant/delete-consultant-shedule')
  Future<dynamic> deleteConsultantSchedule(@Body() Map<String, dynamic> body);
  @POST('/consultant/update-consultant-shedule')
  Future<dynamic> updateConsultantSchedule(@Body() Map<String, dynamic> body);
  @POST('/consultant/update-consultant')
  Future<dynamic> updateConsultantProfile(@Body() Map<String, dynamic> body);
  @POST('/customer/update-customer')
  Future<dynamic> updateCustomerProfile(@Body() Map<String, dynamic> body);
  @POST('/onboarding/update-arrival-time')
  Future<dynamic> updateArrivalTime(@Body() Map<String, dynamic> body);
}
