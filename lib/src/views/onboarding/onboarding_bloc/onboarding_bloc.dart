import 'dart:convert';
import 'dart:developer';

import 'package:appointment_management/api/auth_api/api.dart';
import 'package:appointment_management/api/auth_api/dio.dart';
import 'package:appointment_management/model/auth_model/auth_model.dart';
import 'package:appointment_management/services/local_storage_service.dart';
import 'package:appointment_management/services/locator.dart';
import 'package:appointment_management/src/resources/constants.dart';
import 'package:appointment_management/src/views/Auth/auth_bloc/auth_states.dart';
import 'package:appointment_management/src/views/common_widgets/custom_dialogue.dart';
import 'package:appointment_management/src/views/onboarding/onboarding_bloc/onboarding_events.dart';
import 'package:appointment_management/src/views/onboarding/onboarding_bloc/onboarding_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvents, OnBoardingStates> {
  final authApi = Api(
    dio,
    baseUrl: Constants.baseUrl,
  );
  OnBoardingBloc() : super(OnBoardingInitState()) {
    on<OnBoardingEvents>((event, emit) async {
      if (event is CreateOnBoardEvent) {
        await _login(event, emit);
      }
    });
  }

  Future<void> _login(
      CreateOnBoardEvent event, Emitter<OnBoardingStates> emit) async {
    try {
      emit(
        OnBoardingLoadingState(),
      );
      // AuthResponse res = await authApi.login(
      //   {
      //     "email": event.email,
      //     "password": event.password,
      //     'role_id': event.roleId,
      //   },
      // );

      // if (res.status == 200) {
      //   AuthResponse user = AuthResponse(token: res.token, user: res.user);

      //   locator<LocalStorageService>().saveData(
      //     key: 'user',
      //     value: user.toJson(),
      //   );

      //   emit(AuthSuccessState());
      // } else {
      //   print('getting response  ${res.status}');
      //   emit(AuthFailureState(
      //       message: '${res.message ?? 'Something went wrong'}'));
      // }
    } catch (e, stack) {
      log('Something went wrong in login api: $e', stackTrace: stack);
      emit(OnBoardingFailureState(
          errorMessage: 'Something went wrong, Please try again'));
    }
  }
}
