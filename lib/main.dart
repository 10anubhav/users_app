
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/authentication/signup_screen.dart';
import 'package:users_app/firebase_options.dart';
import 'package:users_app/pages/home_page.dart';

import 'appInfo/app_info.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await Permission.locationWhenInUse.isDenied.then((valueOfPermission)
  {
    if(valueOfPermission)
      {
        Permission.locationWhenInUse.request();
      }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider(
      create: (context)=>AppInfo(),
      child: MaterialApp(
        title: 'Flutter User App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black
        ),
        home: FirebaseAuth.instance.currentUser==null ? LogInScreen() : HomePage(),
      ),
    );
  }
}


