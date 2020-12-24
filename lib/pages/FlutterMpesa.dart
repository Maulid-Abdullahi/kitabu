import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:keytabu_project/pages/Keys.dart';
import 'dart:async';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';


void main() {
  /*Set Consumer credentials before initializing the payment.
    You can get  them from https://developer.safaricom.co.ke/ by creating
    an account and an app.
     */
  MpesaFlutterPlugin.setConsumerKey(mConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(mConsumerSecret);

  runApp(FlutterMpesa());
}

class FlutterMpesa extends StatefulWidget {
  @override
  _FlutterMpesaState createState() => _FlutterMpesaState();
}

class _FlutterMpesaState extends State<FlutterMpesa> {

Future<void> startCheckout({double amount, String phone}) async {
  dynamic transactionInitialisation;
  //Wrap it with a try-catch
  try {
    //Run it
    transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: amount,
        partyA: phone,
        partyB: "174379",
        callBackURL:Uri(scheme: "https", host : "my-app.herokuapp.com", path: "/callback"),
        accountReference:"payment",
        phoneNumber: phone,
        baseUri:Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: "demo",
        passKey:"bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

     print("TRANSACTION RESULT: "+ transactionInitialisation.toString());
    return transactionInitialisation;


  } catch (e) {
    print("CAUGHT EXCEPTION:" + e.toString());
  }

}
  @override
  Widget build(BuildContext context) {
    //default value : width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 360, height: 750);
    return Scaffold(
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          startCheckout(amount: 8.0, phone: "254720304574");
        },
        tooltip: 'Increment',
        child: Text("Pay"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
