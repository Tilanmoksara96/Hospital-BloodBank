import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class ApplicationState extends ChangeNotifier {

  bool _isUserLogged = false;
  bool get isUserLogged => _isUserLogged;


  ApplicationState () {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if(user != null) {
        _isUserLogged = true;
      }else {
        _isUserLogged = false;
      }
      notifyListeners();
    });
  }


}