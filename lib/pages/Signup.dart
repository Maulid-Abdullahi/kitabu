import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:keytabu_project/functions/AppFunction.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keytabu_project/pages/AccountDetails.dart';

class Signup extends StatefulWidget {
 // final String phoneNumber, Email,Password,Name,Location,ParentID  ;
  AppFunction appFunction = new AppFunction();
 // Signup({Key key, this.phoneNumber, this.Email, this.Password, this.Name, this.Location, this.ParentID}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Signup();
  }
}

class _Signup extends State<Signup> {
  final firestoreInstance = Firestore.instance;
  // final databaseReference = FirebaseDatabase.instance.reference();
  bool _isHidden = true;
  var isImageLoaded = false;
  //String dropdownValue = '4Kids';
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    /**this is the screenUtil lines that handle the screen ratios*/

    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    return ModalProgressHUD(
      inAsyncCall: isImageLoaded,
      child: Scaffold(
          body: SingleChildScrollView(
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
                Text('Create an Account',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilder(
                key: _fbKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      attribute: "Phone",
                      keyboardType: TextInputType.phone,
                      obscureText: false,
                      maxLength: 10,
                      validators: [
                        FormBuilderValidators.minLength(10,allowEmpty: true,errorText: "Enter a valid number with 10 characters"),
                        FormBuilderValidators.required(errorText: "Fill this field")
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6.0))),
                          hintText: "Enter Phone No",
                          suffixIcon: Icon(Icons.phone)),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    FormBuilderTextField(
                      attribute: "Name",
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      validators: [
                        FormBuilderValidators.required(errorText: "Fill this field")
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6.0))),
                          hintText: "Enter Name",
                          suffixIcon: Icon(Icons.person)),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    FormBuilderTextField(
                      attribute: "Location",
                      keyboardType: TextInputType.streetAddress,
                      obscureText: false,
                      validators: [
                        FormBuilderValidators.required(errorText: "Fill this field")
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6.0))),
                          hintText: "Enter Location",
                          suffixIcon: Icon(Icons.location_city)),
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
                            errorText: "Email is invalid"),
                        FormBuilderValidators.required(errorText: "Fill this field")
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
                      attribute: "Password",
                      keyboardType: TextInputType.text,
                      obscureText: _isHidden,
                      maxLength: 10,
                      validators: [
                        FormBuilderValidators.required(errorText: "Fill this field"),
                        FormBuilderValidators.minLength(10,allowEmpty: true,errorText: "Enter a valid password with 10 characters"),
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6.0))),
                          hintText: "Enter Password",
                          suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(
                                _isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ))),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    FormBuilderTextField(
                      attribute: "ParentID",
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      validators: [
                         FormBuilderValidators.required(errorText: "Fill this field")
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6.0))),
                          hintText: "ID",
                          suffixIcon: Icon(Icons.perm_identity)),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),

                    // onTap: (){
                    //   String number;
                    //   number=_fbKey.currentState.value["phoneNumber"];
                    // },
                    FlatButton(
                      child: Text("Register"),
                      color: Colors.green,
                      onPressed: () async {
                        if (_fbKey.currentState.saveAndValidate()) {
                          await Navigator.push<String>(
                              context,
                             // Phone, Password,Email, Name,Location, ParentID;
                              MaterialPageRoute(
                                  builder: (context) => AccountDetails(
                                    Email:  _fbKey.currentState.value["Email"],
                                    Password: _fbKey.currentState.value["Password"],
                                    Name: _fbKey.currentState.value["Name"],
                                    Location: _fbKey.currentState.value["Location"],
                                    ParentID: _fbKey.currentState.value["ParentID"],
                                    Phone: _fbKey.currentState.value["Phone"],
                                  )));


                          // Navigator.pushNamed(context, "/Login");

                        }

                        /*await FirebaseAuth.instance.signOut();*/
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/Login');
                      },
                      child: Text.rich(
                        TextSpan(text: 'Have an account', children: [
                          TextSpan(
                            text: ' Login',
                            style: TextStyle(color: Color(0xffEE7B23)),
                          ),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Future showErrorDialog(String email, String message) {
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
