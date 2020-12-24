import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:keytabu_project/functions/AppFunction.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileExtension extends StatefulWidget {
  AppFunction appFunction = new AppFunction();
  @override
  _ProfileExtensionState createState() => _ProfileExtensionState();
}
class _ProfileExtensionState extends State<ProfileExtension> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  StorageReference storageReference = FirebaseStorage.instance.ref();

  File _image;

  final firestoreInstance = Firestore.instance;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool isImageLoaded = false;

  @override
  Widget build(BuildContext context) {
    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: FormBuilder(
              key: _fbKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 120.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40,
                              width: 15,
                              child: Icon(
                                Icons.keyboard_backspace,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Create',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0)),
                      Text(' a profile',
                          style: TextStyle(color: Colors.grey, fontSize: 12.0))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 52,
                            backgroundColor: Colors.green,
                            child: _image != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image,
                                width: 100,
                                height: 100,
                                // fit: BoxFit.fitHeight,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pick an Image',
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  SizedBox(
                    width: 350,
                    child: FormBuilderTextField(
                      attribute: "Name",
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      validators: [
                        //  FormBuilderValidators.email(errorText: "Email is invalid")
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(6.0))),
                          hintText: "Enter profile name",
                          suffixIcon: Icon(Icons.person)),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  SizedBox(
                    width: 350,
                    child: FormBuilderTextField(
                      attribute: "Class",
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      validators: [
                        //  FormBuilderValidators.email(errorText: "Email is invalid")
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(6.0))),
                          hintText: "Enter class level",
                          suffixIcon: Icon(Icons.school)),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.green,
                      child: InkWell(
                        child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(Icons.arrow_forward_ios_outlined)),
                        onTap: () {
                          if (_fbKey.currentState.saveAndValidate()) {
                            uploadFile(_image);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                       _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> uploadFile(File _image) async {
    try {
      DateTime.now().toString();
      StorageUploadTask uploadTask = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_avatar')
          .child('images' + DateTime.now().toString())
          .putFile(_image);

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
// Once the image is uploaded to firebase get the download link.
      String downlaodUrl = await storageTaskSnapshot.ref.getDownloadURL();
      if (uploadTask.isComplete) {
        if (downlaodUrl != null) {
          widget.appFunction.createProfile(_fbKey.currentState.value["Name"],
              downlaodUrl, _fbKey.currentState.value["Class"]);
          Navigator.pushNamed(context, "/ProfilePage");
        }else{

        }

      }

      return downlaodUrl;
    } catch (e) {
      e.code == 'canceled';
    }
  }
}
