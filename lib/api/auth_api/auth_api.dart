import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/onboarding/onboarding_form.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'auth_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;
  @POST('/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);
  @POST('/sign-up')
  Future<AuthResponse> signUp(@Body() Map<String, dynamic> body);
   
  
}
