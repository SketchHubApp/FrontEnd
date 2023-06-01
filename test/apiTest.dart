import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketch/api/api.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  group("api test", (){
    test("login", () async{
      var result = await Api().getLoginAuth('kimjunbeom', 'hk0301234');
      print("Login : ${result["body"]}");
    });
  });
}