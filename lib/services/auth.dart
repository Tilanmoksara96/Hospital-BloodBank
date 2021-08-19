import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //sign in with email and password
  Future<bool> userLogin(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential userCredential) async {
      if(userCredential != null){
        return true;
      }else{
        return false;
      }
    }).catchError((onError) {
      return false;
    });
  }

  //register
  Future<bool> userRegister(String staffId, String name, String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((UserCredential userCredential) async {
             if(userCredential != null){
                await userCredential.user.updateProfile(displayName: name, photoURL: staffId);
               return true;
             }else{
               return false;
             }
    }).catchError((onError) {
      return false;
    });
  }

  Future<bool> sendPasswordResetLink(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    }catch(error) {
      print(error);
      return false;
    }
  }


  //sign out
  Future<void> userLogout() async {
    await _auth.signOut();
  }
}