import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:keytabu_project/pages/RoundedContainer.dart';
import 'package:keytabu_project/pages/ProfilePage.dart';

class AccountDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountDetails();
  }
}

class _AccountDetails extends State<AccountDetails> {
  String color = "Red";
  int tappedIndex = 0;
  bool _isHidden = true;
  bool isImageLoaded = false;
  @override
  Widget build(BuildContext context) {
    /**this is the screenUtil lines that handle the screen ratios*/

    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: InkWell(
          child: Column(

            children: <Widget>[
              Text(
                "Choose your plan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: RoundedContainer(
                        color: color == "Red" ? Colors.red : Colors.white,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 8.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Free",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color == "Red"
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "7 days",
                              style: TextStyle(
                                color:
                                    color == "Red" ? Colors.white : Colors.grey,
                                fontSize: 13.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          color = "Red";
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: RoundedContainer(
                        color: color == "Blue" ? Colors.red : Colors.white,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 8.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "\Ksh 1500",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "Bronze",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          color = "Blue";
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: RoundedContainer(
                        color: color == "Green" ? Colors.red : Colors.white,
                        margin: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 5.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "\Ksh 2000",
                              style: TextStyle(fontWeight: FontWeight.bold)
                                  .copyWith(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              "Silver",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          color = "Green";
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: RoundedContainer(
                        color: color == "Yellow" ? Colors.red : Colors.white,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 8.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "\Ksh 3000",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "Gold",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          color = "Yellow";
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32.0,
                ),
                child: RaisedButton(
                  elevation: 0,
                  padding: const EdgeInsets.all(24.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: InkWell(
                      onTap: () async {
                        String pin = await Navigator.push<String>(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      child: Text("Continue")),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
