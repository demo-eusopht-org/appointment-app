abstract class AuthStates {}

class AuthInitState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthFailureState extends AuthStates {
  String message;
  AuthFailureState({required this.message});
}
