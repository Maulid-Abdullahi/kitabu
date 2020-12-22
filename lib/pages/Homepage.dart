import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keytabu_project/pages/ContentViewExtension.dart';
import 'package:keytabu_project/pages/ContentView.dart';
import 'package:keytabu_project/pages/SubjectsView.dart';

class Homepage extends StatefulWidget {
  final String level, username, image;

  const Homepage({Key key, this.level, this.username, this.image})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  bool isImageLoaded = false;
  ContentViewExtension contentViewExtension;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /**this is the screenUtil lines that handle the screen ratios*/

    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
        body: Stack(
      children: [
          menu(context),
          dashboard(context),
      ],
    ));
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.4 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          elevation: 8,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              //padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onTap: () {
                            setState(() {
                              if (isCollapsed)
                                _controller.forward();
                              else
                                _controller.reverse();

                              isCollapsed = !isCollapsed;
                            });
                          },
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
                         // Firestore.instance.collection('clients').where('searchKey', isEqualTo: searchField.substring(0, 1).toUpperCase()).getDocuments();
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Videos")
                            .where("level", isEqualTo: widget.level)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading..");
                          }

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              //shrinkWrap: true,
                              //ignore: deprecated_member_use
                              children:
                                  snapshot.data.documents.map((documents) {
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
                    width: ScreenUtil()
                        .setWidth(MediaQuery.of(context).size.width),
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
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        ),

                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                        size: 12.0,
                      )
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Videos")
                            .where("level", isEqualTo: widget.level)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading..");
                          }

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              //shrinkWrap: true,
                              //ignore: deprecated_member_use
                              children:
                              snapshot.data.documents.map((documents) {
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
                    width: ScreenUtil()
                        .setWidth(MediaQuery.of(context).size.width),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "Hello",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(20),
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            widget.image,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
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
                Row(
                 // mainAxisSize: MainAxisSize.min,
                 mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Do you want to switch accounts?', style: TextStyle(color: Colors.green, fontSize: 10),),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Menu Options', style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("My Favourites",
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,

                      ),
                    )
                  ],

                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Share with Friends",
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,

                      ),
                    )
                  ],

                ),

                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Switch to Admin Profile",
                        style: TextStyle(color: Colors.black, fontSize: 13)),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,

                      ),
                    )
                  ],

                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
