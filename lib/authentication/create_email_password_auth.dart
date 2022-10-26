


import 'package:firebase_auth/firebase_auth.dart';



final auth =FirebaseAuth.instance;


Future signupMethod( email ,password)async{

  return   await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );


}
Future <UserCredential>loginMethod( email ,password )async{
     return await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    }


