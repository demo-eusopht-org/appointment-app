import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/src/resources/constants.dart';
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
}
