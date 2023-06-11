import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/auth/auth.dart';
import 'package:social_media_app/controller/login_controller.dart';
import 'package:social_media_app/controller/register_controller.dart';
import 'package:social_media_app/theme/dark_theme.dart';
import 'package:social_media_app/theme/light_theme.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(
          create: (BuildContext context) {
            return LoginController();
          },
        ),
        ChangeNotifierProvider<RegisterController>(
          create: (BuildContext context) {
            return RegisterController();
          },
        ),
      ], child :MaterialApp(
      title: 'Social Media App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home:const Auth(),
    ),
    );
  }
}

