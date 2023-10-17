import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Drag to Capture Area')),
        body: ImageCapture(),
      ),
    );
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {

  final GlobalKey globalKey = GlobalKey();
  Rect captureRect = Rect.zero;
  late Offset startDrag;
  late Offset endDrag;

  void updateDrag(DragUpdateDetails details) {
    setState(() {
      endDrag = details.localPosition;
      captureRect = Rect.fromPoints(startDrag, endDrag);
    });
  }

  Future<void> capturePng() async {

    try {
      RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      print(boundary);
      var image = await boundary.toImage(pixelRatio :3);
      ByteData? byteData =
      await image.toByteData(format :ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      img.Image? oriImage = img.decodePng(pngBytes);

      int x=(captureRect.left*3).toInt();
      int y=(captureRect.top*3).toInt();
      int width=(captureRect.width*3).toInt();
      int height=(captureRect.height*3).toInt();

      img.Image croppedImg = img.copyCrop(oriImage!,x,y,width,height);

      File imgFile = new File('/Users/kimjunbeom/Documents/SketchHub_front/assets/images/screenshot.png');
      imgFile.writeAsBytesSync(img.encodePng(croppedImg));

    } catch (e) {

      print(e);

    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart :(details){
        setState(() {
          startDrag =details.localPosition;
          endDrag =details.localPosition;
        });
      },
      onPanUpdate :updateDrag,
      onPanEnd :(details)=>capturePng(),
      child :RepaintBoundary(
        key :globalKey,
        child :Stack(children:[
          Positioned.fill(child :FlutterLogo(size :200)),
          Positioned.fromRect(rect: captureRect, child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 2),),),)
        ]),
      ),
    );
  }
}

