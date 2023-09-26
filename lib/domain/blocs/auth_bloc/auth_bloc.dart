import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:my_vocabulary_app/services/auth_service.dart';
import 'package:my_vocabulary_app/services/util_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitialState()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
    on<GetUserEvent>(_onGetUser);
    on<DeleteAccountConfirmEvent>(_onUpdateUserInterface);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter emit) async {
    final bool isValidSignUp = UtilService.validateSignUp(
      event.userName,
      event.email,
      event.password,
      event.confirmPassword,
    );

    if (!isValidSignUp) {
      emit(const AuthFailureState(message: 'Please check your data'));
      return;
    }

    emit(const AuthLoadingState());

    final bool isSignedUp = await AuthService.signUp(
      event.email,
      event.password,
      event.userName,
    );

    if (isSignedUp) {
      emit(const SignUpSuccessState());
    } else {
      emit(
        const AuthFailureState(
          message: 'Something error, please try again later',
        ),
      );
    }
  }

  Future<void> _onSignIn(SignInEvent event, Emitter emit) async {
    final bool isValidSignIn =
        UtilService.validateSignIn(event.email, event.password);

    if (!isValidSignIn) {
      emit(
        const AuthFailureState(message: 'Please check your email or password'),
      );
      return;
    }

    emit(const AuthLoadingState());

    final bool isSignedIn =
        await AuthService.signIn(event.email, event.password);

    if (isSignedIn) {
      emit(const SignInSuccessState());
    } else {
      emit(
        const AuthFailureState(
          message: 'Something error, please try again later',
        ),
      );
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter emit) async {
    emit(const AuthLoadingState());

    final bool isSignedOut = await AuthService.signOut();

    if (isSignedOut) {
      emit(const SignOutSuccessState());
    } else {
      emit(
        const AuthFailureState(
          message: 'Something error, please try again later',
        ),
      );
    }
  }

  Future<void> _onGetUser(GetUserEvent event, Emitter emit) async =>
      emit(GetUserSuccessState(currentUser: AuthService.currentUser));

  Future<void> _onUpdateUserInterface(
          DeleteAccountConfirmEvent event, Emitter emit) async =>
      emit(const DeleteAccountConfirmSuccessState());

  Future<void> _onDeleteAccount(DeleteAccountEvent event, Emitter emit) async {
    emit(const AuthLoadingState());

    final User currentUser = AuthService.currentUser;
    final bool signInResult =
        await AuthService.signIn(currentUser.email!, event.password);

    if (!signInResult) {
      emit(const AuthFailureState(message: 'Please enter valid password'));
    }

    final bool isAccountDeleted = await AuthService.deleteAccount();

    if (isAccountDeleted) {
      emit(const DeleteAccountSuccessState());
    } else {
      emit(
        const AuthFailureState(
          message: 'Something error, please try again later',
        ),
      );
    }
  }
}
