import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dio = Dio(
  BaseOptions(
    validateStatus: (status) {
      return status == 200 ||
          status == 401 ||
          status == 403 ||
          status == 404 ||
          status == 405 ||
          status == 422 ||
          status == 500;
    },
  ),
)
  ..interceptors.add(PrettyDioLogger(
    compact: true,
    error: true,
    requestHeader: true,
    requestBody: true,
    responseBody: false,
    responseHeader: false,
  ))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final user = locator<LocalStorageService>().getData(key: 'user');

      final headers = options.headers;
      if (user != null && user['token'] != null) {
        headers.addAll({
          'Authorization': 'Bearer ${user['token']}',
        });
      }
      options.headers = headers;

      handler.next(options);
    },
  ));
