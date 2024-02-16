import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices{
  Future<String?> login(String email, String password) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return null;
    }
    on FirebaseAuthException catch(e){
      return "Wrong email or password";
    }
    catch(e){
      return "Try again later";
    }
  }

  Future<String?> register(String email, String password) async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    }
    on FirebaseAuthException catch(e){
      return e.code.replaceAll("-", " ");
    }
    catch(e){
      return "Try again later";
    }
  }

  Future<bool> logout() async{
    try{
      await FirebaseAuth.instance.signOut();
      return true;
    }
    catch(e){
      return false;
    }
  }

  void currentUser(){
    var user = FirebaseAuth.instance.currentUser;
    if(user != null){
      /// There is a logged in user
    }
    else{
      /// No active user
    }
  }

  void loginWithGoogle() async{
    var googleUser = await GoogleSignIn().signIn();
    var googleAuth = await googleUser?.authentication;
    var cred = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(cred);
  }
}