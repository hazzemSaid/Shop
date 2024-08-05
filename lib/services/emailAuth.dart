import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  String email;
  String password;
  EmailAuth({required this.email, required this.password});
  Future<void> emailAuth_create() async {}

  Future<void> emailAuth_signin() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: this.email,
        password: this.password,
      );
      print("Email: ${this.email}");
      print("Password: ${this.password}");
      print("Sign-in successful. User: ${userCredential.user?.email}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        print(
            'The supplied auth credential is incorrect, malformed or has expired.');
      } else {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }
}
