import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/Consultant%20Branch/create_branch.dart';
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
  Future<dynamic> assignConsultantBranchSchedule(@Body() Map<String, dynamic> body);
  @POST('/customer/create-appointment')
  Future<dynamic> createAppointment(@Body() Map<String, dynamic> body);
}
