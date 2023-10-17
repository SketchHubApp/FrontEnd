import 'package:draw_your_image/draw_your_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Drag to Select Area')),
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
  final _controller = DrawController();
  bool _isErasing = false;
  double _strokeWidth = 1.0;
  Color selectedColor = Colors.blue;

  Offset startDrag = Offset(0.0,0.0);
  Offset currentDrag = Offset(0.0,0.0);
  bool isSelecting = false;

  void updateDrag(DragUpdateDetails details) {
    setState(() {
      currentDrag = details.localPosition;
      print(currentDrag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onPanStart :(details){
          setState(() {
            startDrag=details.localPosition;
            currentDrag=details.localPosition;
          });
        },
          onPanUpdate :updateDrag,
          child :Stack(
              children:[
                Container(width :300, height :300, color :Colors.yellow,),
                Positioned.fromRect(rect :(isSelecting)?Rect.fromPoints(startDrag,currentDrag):Rect.zero ,
                  child : Container(decoration : BoxDecoration(border : Border.all(color: Colors.red,width: 2),),),)]),),
        TextButton(
          child :Text('Start Selection'),
          onPressed :(){setState(() { isSelecting = true; });}
          ,),
        TextButton(
          child :Text('End Selection'),
          onPressed :(){setState(() { isSelecting = false; });}
          ,),
      ],
    );
    }
  }
