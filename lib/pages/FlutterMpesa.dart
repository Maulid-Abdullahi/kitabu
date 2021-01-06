import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:keytabu_project/pages/Keys.dart';
import 'package:keytabu_project/pages/PaymentGateway.dart';
import 'dart:async';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:get_it/get_it.dart';
import '../main.dart';
void main() {
  /*Set Consumer credentials before initializing the payment.
    You can get  them from https://developer.safaricom.co.ke/ by creating
    an account and an app.
     */
  runApp(FlutterMpesa());
}

class FlutterMpesa extends StatefulWidget {
  @override
  _FlutterMpesaState createState() => _FlutterMpesaState();
}

class _FlutterMpesaState extends State<FlutterMpesa> {

/*Future<void> startCheckout({double amount, String phone}) async {
  dynamic transactionInitialisation;
  //Wrap it with a try-catch
  try {
    MpesaFlutterPlugin.setConsumerKey('eUwz3iEMbmze6G5sPykngjzbstNP3rBQ');
    MpesaFlutterPlugin.setConsumerSecret('I9URgveOrGeAt2Fl');
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

}*/
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
        onPressed:()async{
          // final response = await getIt<PaymentGateway>().selfTopUp("", "",(){
          //   Navigator.pushNamed(context, "/ProfilePage");
          // });
        },
        tooltip: 'Increment',
        child: Text("Pay"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
