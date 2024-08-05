part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class phoneverifyPhoneNumber_loading extends AuthState {}

class phoneverifyPhoneNumber_success extends AuthState {}

class phoneverifyPhoneNumber_error extends AuthState {
  final String? error;
  phoneverifyPhoneNumber_error({
    required this.error,
  });
}

class phoneSignInWithPhoneAuthCredential_loading extends AuthState {}

class phoneSignInWithPhoneAuthCredential_success extends AuthState {}

class phoneSignInWithPhoneAuthCredential_failed extends AuthState {
  final String error;
  phoneSignInWithPhoneAuthCredential_failed({
    required this.error,
  });
}

class emailAuthCreate_loading extends AuthState {}

class emailAuthCreate_success extends AuthState {}

class emailAuthCreate_failed extends AuthState {
  final String error;
  emailAuthCreate_failed({required this.error});
}

class emailAuthSignIn_loading extends AuthState {}

class emailAuthSignIn_success extends AuthState {}

class emailAuthSignIn_failed extends AuthState {
  final String error;
  emailAuthSignIn_failed({required this.error});
}
