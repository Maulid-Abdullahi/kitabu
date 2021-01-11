import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keytabu_project/pages/Homepage.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isImageLoaded = false;
  @override
  Widget build(BuildContext context) {
    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    return Scaffold(
        body:ListView(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(40),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Create', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0)),
                  Text(' an account', style: TextStyle(color: Colors.grey, fontSize: 14.0))
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: StreamBuilder<QuerySnapshot>(
                    stream:
                    FirebaseFirestore.instance.collection("User_Profile")
                        .where("MasterId",
                        isEqualTo: FirebaseAuth.instance.currentUser.uid
                    )
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading..");
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          shrinkWrap: true,
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: snapshot.data.documents.map((documents) {
                              return Card(
                                child: Container(
                                  child: Column(
                                    children:<Widget> [
                                      InkWell(
                                        onTap: () async {
                                          String pin = await Navigator.push<String>(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Homepage(level: documents.data()["Class"].toString(),
                                                        username: documents.data()["Name"].toString(),
                                                        image: documents.data()["Image"],)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: documents.data()["Image"].toString()==null?Image.asset("assets/image/loading_keytabu.png")
                                                  :Image.network(documents.data()["Image"].toString(),
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,),
                                            ),

                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Name: " + documents.data()["Name"].toString()),
                                            ),
                                            Text(" Class: " + documents.data()["Class"].toString()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                        ),
                      );
                    }),

              ),

            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.green,
                      child: InkWell(
                        child: SizedBox(width:56, height: 56,
                            child: Icon(Icons.add_outlined)),
                        onTap: (){
                          Navigator.pushNamed(context, "/ProfileExtension");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        )
    );
  }
}
