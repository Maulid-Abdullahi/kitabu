import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:keytabu_project/pages/ProfilePage.dart';
import 'package:keytabu_project/pages/Login.dart';
import 'package:keytabu_project/pages/Signup.dart';
import 'package:keytabu_project/pages/ProfileExtension.dart';
import 'package:keytabu_project/pages/Homepage.dart';
import 'package:keytabu_project/pages/ContentViewExtension.dart';
import 'package:keytabu_project/pages/AccountDetails.dart';
import 'package:keytabu_project/pages/CloudFirestoreSearch.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      initialRoute: "/CloudFirestoreSearch ",
      routes: {
        "/ProfilePage":(context)=> ProfilePage(),
        "/Login":(context)=> Login(),
        "/CloudFirestoreSearch ":(context)=> CloudFirestoreSearch (),
        "/AccountDetails":(context)=> AccountDetails(),
        "/ProfileExtension":(context)=> ProfileExtension(),
        "/Signup":(context)=> Signup(),
        "/Homepage":(context)=> Homepage(),
        "/ContentViewExtension":(context)=> ContentViewExtension(),

        // "/viewDetails":(context)=> viewDetails(),
      },

    );
  }
}

