import 'package:sketch/api/apiInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Api{
  String url = ApiInfo.url;
  Map<String, dynamic> result ={};
  Map<String,dynamic> body = {};
  var response;

  Future<Map<dynamic,dynamic>> getLoginAuth(String ID,String PW) async {
    body = {"id" : ID,"pw" : PW};
    try{
      response = await http.post(Uri.parse(url+"login"),
          body:body,
          headers: {'accept': 'application/json',
          }).timeout(const Duration(seconds: 5));
      result = convert.jsonDecode(response.body);
    }catch (Exception){
      result = {"err" : Exception};
    }
    return result;
  }

}