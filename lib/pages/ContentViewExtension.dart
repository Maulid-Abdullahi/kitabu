import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:keytabu_project/functions/AppFunction.dart';
import 'package:keytabu_project/pages/Homepage.dart';

// ignore: must_be_immutable
class ContentViewExtension extends StatefulWidget {
  AppFunction appFunction = new AppFunction();
  final String images, titles, teachers, video_url, video_time,  video_description;

 ContentViewExtension(
      {Key key, this.images, this.teachers, this.titles, this.video_url, this.video_time, this.video_description});

  @override
  State<StatefulWidget> createState() {
    return _ContentViewExtension();
  }
}

class _ContentViewExtension extends State<ContentViewExtension> {
  VideoPlayerController controller;
  Future<void> _initializeVideoPlayerFuture;

  // FloatingActionButton floatingActionButton;
  bool visibility = true;
  bool isImageLoaded = false;
  String isPlaying = "isPlaying";
  String lastTime;

  @override
  Widget build(BuildContext context) {
    /**this is the screenUtil lines that handle the screen ratios*/

    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0), // here the desired height
              child: AppBar(
                leading: Row(
                  children: [
                    InkWell(
                      onTap: () async{
                        Navigator.pop(context);
                          widget.appFunction.continue_watching(widget.video_url, widget.titles, widget.video_description,widget.teachers, widget.images, lastTime);
                       // images, titles, teachers, video_url

                      },
                        child: Icon(Icons.keyboard_backspace,color: Colors.white,))
                  ],
                ),
                backgroundColor: Colors.green,
                actions: <Widget>[],
                // ...
              )),
          body: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.value.initialized
                      ? Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              //    VideoProgressIndicator(_controller, allowScrubbing: true),
                              child: VideoPlayer(controller,),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  "assets/image/loading_keytabu.png",
                                  width: MediaQuery.of(context).size.width,
                                  height: ScreenUtil().setHeight(250),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: VideoProgressIndicator(controller,
                              allowScrubbing: true),
                          width: ScreenUtil().setWidth(200),
                        ),
                        controller.value.isPlaying
                            ? timesetting()
                            : Text(""),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.skip_previous,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: controller.value.isPlaying
                              ? Icon(
                                  Icons.pause_circle_filled,
                                  size: 50,
                                )
                              : Icon(
                                  Icons.play_circle_fill,
                                  size: 50,
                                ),
                        ),
                        onTap: () {
                          setState(() {
                            controller.value.isPlaying
                                ? controller.pause()
                                : controller.play();
                          });
                          print("....................///////////////////////////////,,,,,,,,,,,,,,,,,,,,,,,,......................///////////////////////////"+lastTime);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.skip_next,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      String pin = await Navigator.push<String>(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ContentViewExtension())); //SideMenu
                    },
                    child: ClipRRect(
                      child: Image.asset(
                        widget.images,
                        //height: ScreenUtil().setHeight(10),
                        width: ScreenUtil().setWidth(300),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.titles,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Text(
                    widget.teachers,
                    style: TextStyle(
                        color: Colors.green, fontSize: ScreenUtil().setSp(11)),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('The Laws Of Physics',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Scientific laws or laws of science are statements, \nbased on repeated experiments or observations, \nthat describe or predict \na range of natural phenomena. \nThe term law has diverse usage in many \ncases across all fields of natural science.'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'By: ChrisKot',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Play All',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Row(children: [
                        ClipRRect(
                          child: Image.asset(
                            widget.images,
                            height: ScreenUtil().setHeight(90),
                            width: ScreenUtil().setWidth(60),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Text(
                                      'The Theory Of SquareRoots',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(90),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'James Con',
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(120),
                                  ),
                                  Text(
                                    '3.30mins',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  // SizedBox(
                                  //   width: ScreenUtil().setWidth(30),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          )));
    }
  }

  Widget timesetting() {
    if (controller.value.isPlaying) {
      lastTime=controller.value.position.abs().toString().substring(2,
          controller.value.duration.abs().toString().length - 7);
      print("....................///////////////////////////////,,,,,,,,,,,,,,,,,,,,,,,,......................///////////////////////////"+lastTime);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lastTime +
                  " / ",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              controller.value.duration.abs().toString().substring(
                  2, controller.value.duration.abs().toString().length - 7),
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      );
    }

  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    /*SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.network(widget.video_url)

      ..initialize().then((_) {
        setState(() {
          if (widget.video_url != null) {
            controller.play();
            //controller.seekTo(controller.value.position + Duration(minutes: 15));
          }
        });
      });
    // Initielize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = controller.initialize();

    // Use the controller to loop the video.
    controller.setLooping(true);
    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true); //loop through video
    controller.initialize(); //initialize the VideoPlayer
  }
}
