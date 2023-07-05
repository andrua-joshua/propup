import 'package:firebase_auth/firebase_auth.dart';

//this abstract class will be used for the 
// ->Registration
// ->SignIn
// ->SignOut

//ignore:camel_case_types
abstract class userRepository<T>{

  Future<T> register();
  Future<T> signIn();
  Future<void> signOut();
}


class EmailUser implements userRepository<UserCredential>{

  final String email;
  final String password;

  const EmailUser({
    required this.email,
    required this.password
  });

  @override
  Future<UserCredential> register() async{
    final auth = await FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: email, password: password);
  
    return auth;
  }

  @override
  Future<UserCredential> signIn() async{
    final auth = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);

      return auth;
  }

  @override
  Future<void> signOut() async{
    FirebaseAuth.instance.signOut();
  }

}