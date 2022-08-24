import 'package:dio/dio.dart';

//https://newsapi.org/v2/top-headlines/sources?category=businessapiKey=API_KEY
//https://api.currentsapi.services/v1/search?apiKey=y2ToAyb9_TIa0LqdGsemlLhto3xM4UspmI-_fEWsehn_izQI&category=sports&country=eg
//https://newsapi.org/
//v2/everything
// q=tesla&from=2022-07-21&sortBy=publishedAt&apiKey=6ae99ef05c09410c94c46a4ac4322676


//https://newsapi.org/v2/everything?q=zamalek&apiKey=6ae99ef05c09410c94c46a4ac4322676

class DioHelper{
  static late Dio dio;

  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'http://api.mediastack.com/',
          receiveDataWhenStatusError: true
        )
    );
  }

  static Future<Response> getData({required String url,required Map<String,dynamic> query})async{
    return await dio.get(url,queryParameters: query);
  }


}

//'q':'tesla',
//                     'from':'2022-07-21',
//                     'sortBy':'publishedAt',
//                     'apikey':'6ae99ef05c09410c94c46a4ac432267',