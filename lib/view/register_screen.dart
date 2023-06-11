import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controller/register_controller.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;

  const RegisterScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePassController = TextEditingController();
  var showPass = false;
  var showLoading = false;

  void register() async {
    setState(() {
      showLoading = true;
    });
    if (passwordController.text != retypePassController.text) {
      setState(() {
        showLoading = false;
      });
      displayMessage('Password don`t match');
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({
        'username': emailController.text.split('@')[0], //initially username
        'bio': 'empty bio', // initially empty bio
        //add any additional feature if needed
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }));
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      displayMessage(e.code);
    }
  }

  void displayMessage(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(msg),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<RegisterController>(context);
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
                  'Let`s create  an account for you',
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
                  hintText: 'Password',
                  obscureText:  controller.showPassword,
                  icon: IconButton(
                    onPressed: () => controller.togglePasswordIcon(),
                    icon: Icon(
                        controller.showPassword ? Icons.visibility : Icons.visibility_off,color:controller.showPassword? Colors.black:Colors.grey,),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: retypePassController,
                  hintText: 'Retype password',
                  obscureText: controller.retypeShowPassword,
                  icon: IconButton(
                    onPressed:()=> controller.toggleRetypePasswordIcon(),
                    icon: Icon(
                      controller.retypeShowPassword? Icons.visibility : Icons.visibility_off,color:controller.retypeShowPassword? Colors.black:Colors.grey,),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  title: 'Sign up',
                  onTap: () => controller.register(
                      context,
                      emailController.text,
                      passwordController.text,
                      retypePassController.text),
                  loading: controller.loading,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login here',
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
    ;
  }
}
