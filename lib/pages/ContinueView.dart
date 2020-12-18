import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:keytabu_project/pages/ContinueViewExtension.dart';

class ContinueView extends StatefulWidget {
  final String videoImage, videoTitle, teacher, video_url;

  const ContinueView(
      {Key key,
        this.videoImage,
        this.videoTitle,
        this.teacher,
        this.video_url});

  @override
  State<StatefulWidget> createState() {
    return _ContinueViewState();
  }
}

class _ContinueViewState extends State<ContinueView> {
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
                      builder: (context) => ContinueViewExtension(
                        images: widget.videoImage,
                        teachers: widget.teacher,
                        titles: widget.videoTitle,
                        video_url: widget.video_url,
                      )));
            },
            child: ClipRRect(
              child: Image.asset(
                widget.videoImage,
                height: ScreenUtil().setHeight(130),
                width: ScreenUtil().setWidth(100),
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
