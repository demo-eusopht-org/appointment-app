import 'package:flutter_bloc/flutter_bloc.dart';

// Define events
abstract class LoginEvent {}

class LoginSuccess extends LoginEvent {}

class LoginFailure extends LoginEvent {}

// Define state
class LoginState {}

// Define bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEvent>((event, emit) {
      if (event is LoginSuccess) {
        emit(LoginState()); // Emit true to indicate loading
      } else if (event is LoginFailure) {}
    });
  }

  // @override
  // Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //   if (event is LoginSuccess) {
  //     yield LoginState();
  //   } else if (event is LoginFailure) {
  //     // Handle login failure
  //   }
  // }
}
