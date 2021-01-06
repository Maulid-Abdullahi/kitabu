import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keytabu_project/functions/AppFunction.dart';
import 'package:keytabu_project/pages/Signup.dart';
import 'package:keytabu_project/pages/ProfilePage.dart';

class Login extends StatefulWidget {
  AppFunction appFunction = new AppFunction();
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  bool _isHidden = true;
  bool isImageLoaded = false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    /**this is the screenUtil lines that handle the screen ratios*/

    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: _fbKey,
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(50),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('KEYTABU',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Login',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                FormBuilderTextField(
                  attribute: "Email",
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  validators: [
                    FormBuilderValidators.email(
                        errorText: "Enter a valid email")
                  ],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0))),
                      hintText: "Enter Email",
                      suffixIcon: Icon(Icons.email)),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                FormBuilderTextField(
                  obscureText: _isHidden,
                  attribute: "Password",
                  keyboardType: TextInputType.text,
                  maxLength: 128,
                  // obscureText: true,
                  validators: [
                    //  FormBuilderValidators.email(errorText: "Email is invalid")
                  ],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0))),
                      hintText: "Enter Password",
                      suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                          ))),
                )
              ],
            ),
          ),
        ),
        FlatButton(
          child: Text("Login"),
          color: Colors.green,
          onPressed: () async {
            if (_fbKey.currentState.saveAndValidate()) {
              try {
                UserCredential userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _fbKey.currentState.value["Email"],
                        password: _fbKey.currentState.value["Password"]);
                if (userCredential != null) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ProfilePage()));
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                  showErrorDialog("Login State", "Wrong Credentials.");
                } else if (e.code == 'wrong-password') {
                  showErrorDialog("Login State", "Wrong Credentials.");
                  print('Wrong password provided for that user.');
                }
              }
              User user = FirebaseAuth.instance.currentUser;

              if (!user.emailVerified) {
                await user.sendEmailVerification();
              }
            }
            /*await FirebaseAuth.instance.signOut();*/
          },
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Signup()));
          },
          child: Text.rich(
            TextSpan(text: 'Don\'t have an account', children: [
              TextSpan(
                text: ' Signup',
                style: TextStyle(color: Color(0xffEE7B23)),
              ),
            ]),
          ),
        ),
      ],
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.appFunction.AuthState();
  }

  void showErrorDialog(String email, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: SizedBox(height: 30.0, child: Text(email)),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message),
              ),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: InkWell(
                      child: Text("OK"),
                      onTap: () async {
                        Navigator.pop(context);
                      },
                    ))
              ],
            ));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
