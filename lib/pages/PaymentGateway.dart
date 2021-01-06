import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

class PaymentGateway {

  Dio dio;
  String baseUrl = "https://41.215.130.247:4349/mpesa/v1/push";
  /*String  baseUrl = "https://b6e8423c5a89.ngrok.io/mpesa/v1";*/
  PaymentGateway() {
    Map<String, String> headers = new Map();
    headers.putIfAbsent(
        Headers.acceptHeader, () => ContentType.json.toString());

    dio = Dio(
      BaseOptions(
          connectTimeout: 30000,
          baseUrl: baseUrl,
          responseType: ResponseType.json,
          headers: headers,
          contentType: ContentType.json.toString(),
          validateStatus: (v) => true),
    );
    /*dio.options.headers["Authorization"] = "b6777c75-e4fb-4329-81b9-a16576287a81";*/
    dio.options.contentType = Headers.formUrlEncodedContentType;
    dio.options.contentType = Headers.jsonContentType;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.interceptors.add(
      InterceptorsWrapper(onResponse: (Response response) {
        response.data["code"] = response.statusCode;
        return response;
      }, onRequest: (RequestOptions options) {
/* options.headers.putIfAbsent("Host", () => baseUrl)*/
/*options.headers.putIfAbsent("Content-Length", () => options.data.length);*/
        print("ONREQUEST 2222`");
        print(options.headers.toString());
        print("ONREQUEST 111111`");
        print(options.data.toString());
        print("ONREQUEST Interceptor ended`");
        return options;
      }),
    );
  }

  Future<Map> selfTopUp(dynamic phoneNumber,dynamic amount) async {
    try {
      // phoneNumber = phoneNumber;
      Map<dynamic, dynamic> payload = {
        "Amount": amount,
        "PhoneNumber": phoneNumber,
        "AccountReference": "78907"
      };
      Response resp = await dio.post(baseUrl,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              "merchantId":"b6777c75-e4fb-4329-81b9-a16576287a81",
            },
          ),
       data:payload,
      );
    print(resp.statusCode);
      if (resp.statusCode == 200) {
        print("success" + resp.statusMessage.toString());
        print("RESPONSE"+resp.toString());

      } else {
        print("an error occur" + resp.statusMessage.toString());

      }

      return resp.data;
    } on DioError catch (exception) {
      print(exception);
      return {
        'code': 500,
        'message':
            'An error occur when performing your request, please try again'
      };
    }
  }

}
