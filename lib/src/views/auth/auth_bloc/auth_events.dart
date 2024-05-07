abstract class AuthEvents {}

class LoginEvent extends AuthEvents {
  final String email;
  final String password;
  final int roleId;

  LoginEvent({
    required this.email,
    required this.password,
    required this.roleId,
  });
}

class SignUpEvent extends AuthEvents {
  final String name;
  final String email;
  final String password;

  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}
