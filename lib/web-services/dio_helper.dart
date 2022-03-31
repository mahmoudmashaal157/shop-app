import 'package:dio/dio.dart';
import 'package:shopping/common-use/constants.dart';

class DioHelper{
  static late Dio dio;

  static void init(){
    dio=Dio(
      BaseOptions(
        baseUrl: URL,
        headers: {
          "lang":"ar",
          "Content-Type":"application/json"
        }
      ),
    );
  }

  static Future<Response> post ({
    required String path,
    Map<String,dynamic>?data,
    String? token
  })async
  {
    dio.options.headers={"Authorization":token};
    return await dio.post(
      path,
      data: data,
    );
  }

  static Future<Response>get({
    required String path,
    String? token
  })async{
    dio.options.headers={"Authorization":token};
    return await dio.get(path);
  }

  static Future<Response>put({
    required String path,
    Map<String,dynamic>?data,
    String? token
  })async{
    dio.options.headers={"Authorization":token};
    return await dio.put(path,
    data: data
    );
  }



}