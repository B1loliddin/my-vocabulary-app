part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class SignUpEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpEvent({
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

class GetUserEvent extends AuthEvent {
  const GetUserEvent();
}

class DeleteAccountConfirmEvent extends AuthEvent {
  const DeleteAccountConfirmEvent();
}

class DeleteAccountEvent extends AuthEvent {
  final String password;

  const DeleteAccountEvent({required this.password});
}
