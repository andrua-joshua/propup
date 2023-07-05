import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//this abstract class will be used for the
// ->Registration
// ->SignIn
// ->SignOut

//ignore:camel_case_types
abstract class userRepository<T> {
  Future<T> register();
  Future<T> signIn();
  Future<void> signOut();
}

class EmailUser implements userRepository<UserCredential> {
  final String email;
  final String password;

  const EmailUser({required this.email, required this.password});

  @override
  Future<UserCredential> register() async {
    final auth = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    return auth;
  }

  @override
  Future<UserCredential> signIn() async {
    final auth = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return auth;
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  static Future<void> validateUser(String code) async{
    try{
      await FirebaseAuth.instance.checkActionCode(code);
      await FirebaseAuth.instance.applyActionCode(code);

      await FirebaseAuth.instance.currentUser?.reload();
    }catch(e){}
  }
}

//ignore:camel_case_types
class DrilloxGoogleUsers{
  
  Future<UserCredential?> signIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    late AuthCredential userCredential;
    if(googleSignInAccount!=null){
      final GoogleSignInAuthentication googleSignInAuthentication= await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );
      userCredential = credential;

      return FirebaseAuth.instance.signInWithCredential(
        credential);
    }

    return null;
  }

  
  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }
}
