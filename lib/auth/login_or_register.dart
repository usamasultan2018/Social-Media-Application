import 'package:flutter/material.dart';
import 'package:social_media_app/view/login_screen.dart';
import 'package:social_media_app/view/register_screen.dart';
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially  show the login screen
  bool showLoginPage  = true;
  void togglePages(){
    setState(() {
      showLoginPage =!showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage ){
      return LoginScreen(onTap: togglePages);
    }
    else{
      return RegisterScreen(onTap: togglePages);
    }
  }
}
