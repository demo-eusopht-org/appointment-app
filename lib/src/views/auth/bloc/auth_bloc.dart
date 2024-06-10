import 'dart:convert';
import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/Auth/auth_bloc/auth_events.dart';
import 'package:appointment_management/src/views/Auth/auth_bloc/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final authApi = Api(
    dio,
    baseUrl: Constants.baseUrl,
  );
  AuthBloc() : super(AuthInitState()) {
    on<AuthEvents>((event, emit) async {
      if (event is LoginEvent) {
        await _login(event, emit);
      } else if (event is SignUpEvent) {
        await _signUp(event, emit);
      }
    });
  }

  Future<void> _login(LoginEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(
        AuthLoadingState(),
      );
      AuthResponse res = await authApi.login(
        {
          "email": event.email,
          "password": event.password,
          'role_id': event.roleId,
        },
      );

      if (res.status == 200) {
        AuthResponse user = AuthResponse(token: res.token, user: res.user);

        await locator<LocalStorageService>().saveData(
          key: 'user',
          value: user.toJson(),
        );
        await locator<LocalStorageService>().saveData(
          key: 'businessId',
          value: res.businessId,
        );

        emit(AuthSuccessState());
      } else {
        print('getting response  ${res.status}');
        emit(AuthFailureState(
            message: '${res.message ?? 'Something went wrong'}'));
      }
    } catch (e, stack) {
      log('Something went wrong in login api: $e', stackTrace: stack);
      emit(AuthFailureState(message: 'Something went wrong, Please try again'));
    }
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(
        AuthLoadingState(),
      );
      AuthResponse res = await authApi.signUp(
        {
          "name": event.name,
          "email": event.email,
          "password": event.password,
        },
      );

      if (res.status == 200) {
        AuthResponse user = AuthResponse(token: res.token, user: res.user);
        locator<LocalStorageService>().saveData(
          key: 'user',
          value: user.toJson(),
        );
        emit(AuthSuccessState());
      } else {
        emit(AuthFailureState(
            message: '${res.message ?? 'Something went wrong'}'));
      }
    } catch (e, stack) {
      log('Something went wrong in signUp api: $e', stackTrace: stack);
      emit(AuthFailureState(
          message: 'Something went wrong in please try again'));
    }
  }
}
