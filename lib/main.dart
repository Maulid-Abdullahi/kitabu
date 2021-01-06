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
import 'package:keytabu_project/pages/FlutterMpesa.dart';
import 'package:keytabu_project/pages/EditProfile.dart';
import 'package:get_it/get_it.dart';
import 'package:keytabu_project/pages/PaymentGateway.dart';

void main() async{
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<PaymentGateway>(PaymentGateway());
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

      initialRoute: "/Login",
      routes: {
        "/ProfilePage":(context)=> ProfilePage(),
        "/Login":(context)=> Login(),
        "/EditProfile":(context)=> EditProfile(),
        "/FlutterMpesa":(context)=> FlutterMpesa(),
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

