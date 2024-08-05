import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/models/userporfile.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  profile? user;
  String? userName, email, password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  // Phone Authentication Methods
  void sendOTP(String phoneNumber) async {
    emit(phoneverifyPhoneNumber_loading());
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
      print('done');
      emit(phoneverifyPhoneNumber_success());
    } catch (e) {
      emit(phoneverifyPhoneNumber_error(error: e.toString()));
    }
  }

  Future<void> verifyOTP(String otp) async {
    emit(phoneSignInWithPhoneAuthCredential_loading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: otp);
      await _auth.signInWithCredential(credential);
      emit(phoneSignInWithPhoneAuthCredential_success());
    } catch (e) {
      emit(phoneSignInWithPhoneAuthCredential_failed(error: e.toString()));
    }
  }

  // Email Authentication Methods
  void createAccount({
    required String email,
    required String password,
  }) async {
    emit(emailAuthCreate_loading());
    try {
      print("Creating account with Email: $email and Password: $password");
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Account creation successful for Email: $email");
      emit(emailAuthCreate_success());
      this.email = email;
      this.password = password;
      this.userName = "name";
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException for $email: ${e.code} - ${e.message}");
      emit(emailAuthCreate_failed(error: e.code));
    } catch (e) {
      print("An unexpected error occurred for $email: $e");
      emit(emailAuthCreate_failed(error: e.toString()));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(emailAuthSignIn_loading());
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      this.email = email;
      this.password = password;
      this.userName = "name";
      emit(emailAuthSignIn_success());
      print("User signed in successfully. Email: ${credential.user?.email}");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException for $email: ${e.code} - ${e.message}");
      emit(emailAuthSignIn_failed(error: e.code));
    } catch (e) {
      print("An unexpected error occurred for $email: $e");
      emit(emailAuthSignIn_failed(error: e.toString()));
    }
  }

  void profilee() {
    user = new profile(
        userName: this.userName!, email: this.email!, password: this.password!);
  }
}
