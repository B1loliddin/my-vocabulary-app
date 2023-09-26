part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthFailureState extends AuthState {
  final String message;

  const AuthFailureState({required this.message});
}

class SignUpSuccessState extends AuthState {
  const SignUpSuccessState();
}

class SignInSuccessState extends AuthState {
  const SignInSuccessState();
}

class SignOutSuccessState extends AuthState {
  const SignOutSuccessState();
}

class GetUserSuccessState extends AuthState {
  final User currentUser;

  const GetUserSuccessState({required this.currentUser});
}

class DeleteAccountConfirmSuccessState extends AuthState {
  const DeleteAccountConfirmSuccessState();
}

class DeleteAccountSuccessState extends AuthState {
  const DeleteAccountSuccessState();
}
