import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  login(String email, String password) {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  logout() {
    FirebaseAuth.instance.signOut();
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
