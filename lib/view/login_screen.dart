import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controller/login_controller.dart';
import 'package:social_media_app/view/home_screen.dart';
import 'package:social_media_app/widgets/custom_button.dart';
import 'package:social_media_app/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;

  const LoginScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var showPass = true;

  // login user
  // void login() async {
  //   setState(() {
  //     showLoading = true;
  //   });
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text, password: passwordController.text);
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  //       return HomeScreen();
  //     }));
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       showLoading = false;
  //     });
  //     displayMessage(e.code);
  //   }
  // }
  //
  // void displayMessage(String msg) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text(msg),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<LoginController>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Icon(
                    Icons.lock,
                    size: 150,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                //welcome msg
                const Text(
                  'Welcome back, you`ve been missed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: '********',
                  obscureText: controller.showPassword,
                  icon: IconButton(
                    onPressed:()=>controller.togglePages(),
                    icon: Icon(
                        controller.showPassword ? Icons.visibility : Icons.visibility_off,color:Colors.black,),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  title: 'Login',
                  onTap:()=> controller.login(context, emailController.text, passwordController.text),
                  loading: controller.loading,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member ? ',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register Now ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
