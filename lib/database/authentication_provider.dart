import 'package:firebase_auth/firebase_auth.dart';
import 'package:fighthunger/controllers/file_handler.dart';

class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;

  AuthenticationProvider(this.firebaseAuth);
  AuthStorage auth = AuthStorage();

  Stream<User> get authState => firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await auth.signOut();
    await firebaseAuth.signOut();
  }

  Future<void> tryLocalSignIn() async {
    String contents = await auth.readAuth();
    if (contents != ''){
      var l = contents.split("\n");
      signIn(email: l[0], password: l[1]);
    }
  }

  Future<String> signIn({String? email, String? password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      await auth.writeAuth(email, password);

      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String? email, String? password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await auth.writeAuth(email, password);

      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> uid() async {
    return firebaseAuth.currentUser.uid;
  }
}