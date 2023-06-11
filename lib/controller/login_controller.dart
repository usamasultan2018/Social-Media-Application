import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/utils/utilis.dart';

import '../view/home_screen.dart';

class LoginController extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  // loading method........
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
 bool _showPassword =false;
  bool get showPassword{
    return _showPassword;
  }
  void togglePages( ){
      _showPassword =! _showPassword;
      notifyListeners();
  }
  void login(BuildContext context, String email, String password) async {
    setLoading(true);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) {
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ),
            );
              Utils.toastMessage('Successfully login');
            }).onError((error, stackTrace) {
                Utils.toastMessage(error.toString());
                setLoading(false);
      }
      );
    }
     on FirebaseAuthException catch (e) {
      setLoading(false);
      Utils.toastMessage(e.code);
    }
    catch(e){
      setLoading(false);
      Utils.toastMessage(e.toString());
    }

  }
}
