import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends StatefulWidget {
  @override
  _MyPainterState createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> {
  Rect rect = Rect.zero;
  Offset startDrag = Offset(0, 0);
  Offset currentDrag = Offset(0.0,0.0);
  // Add your image asset in the AssetImage path.
  final img = AssetImage('assets/images/book.png');
  ImageInfo? imageInfo;
  bool isSelecting = false;
  Rect captureRect = Rect.zero;
  void loadImage() async{
    final completer = Completer<ImageInfo>();
    final listener = ImageStreamListener((ImageInfo info, _) {
      if (!completer.isCompleted) completer.complete(info);
    });

    img.resolve(ImageConfiguration()).addListener(listener);
    imageInfo = await completer.future;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadImage();
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details){
        setState(() {
          startDrag=details.localPosition;
        });
      },
      onPanUpdate: updateDrag,
      child:Stack(
        children: [
          Positioned.fromRect(
            rect :captureRect,
            child : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/book.png'),
                ),
              ),
            ),
          ),
          // CustomPaint(
          //   painter: BoxPainter(captureRect,
          //       imageInfo!.image),
          // )
        ],
      ),
    );



  }

  void updateDrag(DragUpdateDetails details){
    setState(() {
      currentDrag = details.localPosition;
      captureRect = Rect.fromPoints(startDrag, currentDrag);
      print(currentDrag);
    });
  }
}

class BoxPainter extends CustomPainter {

  BoxPainter(this.rect,this.image);

  final Rect rect;
  final ui.Image image;

  void paint(Canvas canvas, Size size){
    canvas.drawImageRect(image ,rect ,rect , Paint());
  }

  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
