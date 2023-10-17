import 'dart:typed_data';

import 'package:sketch/api/apiInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Api{
  String url = ApiInfo.url;
  String aiUrl = ApiInfo.aiUrl;
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

  Future<Map<dynamic,dynamic>> getAiSketch(Uint8List data) async{
    body = {"imageData": data};
    print("body: "+body.toString());
    try{
      response = await http.post(Uri.parse(aiUrl), body: convert.jsonEncode(body), headers: {'accept': 'application/json',}).timeout(const Duration(seconds: 5));
      result = convert.jsonDecode(response.body);
      print(result['body'].toString());
      Uint8List decodeData = convert.base64Decode(result['body'].toString().substring(2,result['body'].toString().length-4));
      result['body'] = decodeData;
    }catch(Exception){
      result = {"err" : Exception};
    }
    return result;
  }

}