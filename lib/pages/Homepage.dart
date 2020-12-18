import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keytabu_project/pages/ContentViewExtension.dart';
import 'package:keytabu_project/pages/ContentView.dart';
import 'package:keytabu_project/pages/SubjectsView.dart';

class Homepage extends StatefulWidget {
  final String level,username, image;

  const Homepage({Key key, this.level, this.username, this.image}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  bool isImageLoaded = false;
  ContentViewExtension contentViewExtension;


  @override
  Widget build(BuildContext context) {
    /**this is the screenUtil lines that handle the screen ratios*/

    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.clear_all,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      widget.image,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "Hello",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(25),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          widget.username,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.search,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    'What new do you want to learn',
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    'New Content',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            // future: Firebase.initializeApp(),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance.collection("Videos").where("level",
                    isEqualTo: widget.level).snapshots(),
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      //shrinkWrap: true,
                      //ignore: deprecated_member_use
                      children: snapshot.data.documents.map((documents) {
                        return ContentView(
                          videoImage: documents.data()["image"],
                          teacher: documents.data()["teacher"],
                          videoTitle: documents.data()["video_title"],
                          video_url: documents.data()["video_url"],
                        );
                      }).toList(),
                    ),
                  );
                }),
            height: ScreenUtil().setHeight(300),
            width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('My Subjects',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            //  height: ScreenUtil().setHeight(3),
          ),
          Container(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(15),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    child: SubjectsView(
                      category: "Class 4",
                      image: "assets/book.jpg",
                      subject: "English",
                    ),
                  ),
                  SubjectsView(
                    category: "Class 4",
                    image: "assets/book.jpg",
                    subject: "Math",
                  ),
                  SubjectsView(
                    category: "Class 4",
                    image: "assets/book.jpg",
                    subject: "Physics",
                  ),
                  SubjectsView(
                    category: "Class 4",
                    image: "assets/book.jpg",
                    subject: "Kiswahili",
                  ),
                ],
              )),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  'More Subjects',
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    'Continue Watching',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            // future: Firebase.initializeApp(),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance.collection("Videos").snapshots(),
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      //shrinkWrap: true,
                      //ignore: deprecated_member_use
                      children: snapshot.data.documents.map((documents) {
                        return ContentView(
                          videoImage: documents.data()["image"],
                          teacher: documents.data()["teacher"],
                          videoTitle: documents.data()["video_title"],
                          video_url: documents.data()["video_url"],
                        );
                      }).toList(),
                    ),
                  );
                }),
            height: ScreenUtil().setHeight(300),
            width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firebase.initializeApp().whenComplete(() {
    //   print("completed");
    //   setState(() {});
    // });
  }
}
