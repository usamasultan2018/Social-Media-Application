import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/utils/utilis.dart';

import '../view/home_screen.dart';

class RegisterController  extends ChangeNotifier{
  bool _loading = false;
  bool get loading => _loading;

  bool _showPassword =false;
  bool get showPassword =>_showPassword;
  bool _retypeShowPassword = false;
  bool get retypeShowPassword =>_retypeShowPassword;

  // loading method........
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  // toggle method
  void togglePasswordIcon( ){
    _showPassword =! _showPassword;
    notifyListeners();
  }
  void toggleRetypePasswordIcon( ){
   _retypeShowPassword =! retypeShowPassword;
    notifyListeners();
  }
  void register(BuildContext context,String email, String password,String retypePassword) async {

    if(password != retypePassword){
      setLoading(false);
     Utils.toastMessage('Password don`t match');
      return;
    }
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({
        'username':email.split('@')[0],//initially username
        'bio':'empty bio',// initially empty bio
        // add any additional feature if needed
      }).then((value) {
        Utils.toastMessage('Sign Up successfully');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return const HomeScreen();
        }));
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    }
    on FirebaseAuthException catch  (e){
      setLoading(false);
      Utils.toastMessage(e.code);
    }
    catch(e){
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}