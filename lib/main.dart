import 'package:flutter/material.dart';
import 'package:sketch/screens/login.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:draw_your_image/draw_your_image.dart';
import 'package:flutter/rendering.dart';
import 'package:collection/collection.dart';
import 'screens/test.dart';
// login -> home -> workspace or social screen

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
    ),
  );
}
