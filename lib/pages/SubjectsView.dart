import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SubjectsView extends StatefulWidget {
  final String image, subject, category;

  const SubjectsView({Key key, this.image, this.subject, this.category});

  @override
  State<StatefulWidget> createState() {
    return _SubjectsViewState();
  }
}

class _SubjectsViewState extends State<SubjectsView> {
  bool isImageLoaded = false;

  @override
  Widget build(BuildContext context) {
    /**this is the screenUtil lines that handle the screen ratios*/

    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    {
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.category,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Image.asset(
                  widget.image,
                  height: ScreenUtil().setHeight(40),
                  width: ScreenUtil().setWidth(50),
                ),
                Text(
                  widget.subject,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
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
      );
    }
  }
}