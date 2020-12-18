import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ContinueViewExtension extends StatefulWidget {
  final String images, titles, teachers, video_url;

  const ContinueViewExtension(
      {Key key, this.images, this.teachers, this.titles, this.video_url});

  @override
  State<StatefulWidget> createState() {
    return _ContinueViewExtension();
  }
}

class _ContinueViewExtension extends State<ContinueViewExtension> {
  VideoPlayerController controller;
  // FloatingActionButton floatingActionButton;
  bool visibility = true;
  bool isImageLoaded = false;

  @override
  Widget build(BuildContext context) {
    /**this is the screenUtil lines that handle the screen ratios*/

    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    {
      return Scaffold(
          body: ListView(children: [
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
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
                  ),
                ],
              ),
            ),
            visibility
                ? Column(
              children: [],
            )
                : Column(
              children: [],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //  width: MediaQuery.of(context).size.width,
                      child: controller.value.initialized
                          ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      )
                          : Container(
                        child: Column(
                          children: [
                            Image.asset("assets/loading_enta_gif.jpg")
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (visibility)
                        visibility = false;
                      else
                        visibility = true;
                    });
                  },
                ),
                InkWell(
                  onTap: () async {
                    String pin = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ContinueViewExtension())); //SideMenu
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
                                'Scientific laws or laws of science are statements,'
                                    ' \nbased on repeated experiments or observations,'
                                    ' \nthat describe or predict \na range of natural phenomena.'
                                    ' \nThe term law has diverse usage in many \ncases '
                                    'across all fields of natural science.'),
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
                                color: Colors.green, fontWeight: FontWeight.bold),
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
                            offset: Offset(0, 3), // changes position of shadow
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
          ]));
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
          }
        });
      });
  }
}
