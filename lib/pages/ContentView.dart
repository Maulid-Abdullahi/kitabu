import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:keytabu_project/pages/ContentViewExtension.dart';
import 'package:video_player/video_player.dart';

class ContentView extends StatefulWidget {
  final String videoImage, videoTitle, teacher,video_url;

  const ContentView({Key key, this.videoImage, this.teacher, this.videoTitle, this.video_url});

  @override
  State<StatefulWidget> createState() {
    return _ContentViewState();
  }
}

class _ContentViewState extends State<ContentView> {
  VideoPlayerController controller;
  bool  visibility=true;
  bool isImageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              String pin = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContentViewExtension(
                        images: widget.videoImage,
                        teachers: widget.teacher,
                        titles: widget.videoTitle,
                        video_url: widget.video_url,
                      )));
            },
            child: ClipRRect(
              child: Image.network(
                widget.videoImage,
                height: ScreenUtil().setHeight(200),
                width: ScreenUtil().setWidth(340),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.videoTitle,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Text(
            widget.teacher,
            style: TextStyle(
                color: Colors.green, fontSize: ScreenUtil().setSp(11)),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.network(widget.video_url)
      ..initialize().then((_) {});

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitDown,
    //   DeviceOrientation.portraitUp
    // ]);
  }

}