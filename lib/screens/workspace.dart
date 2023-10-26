import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:draw_your_image/draw_your_image.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;
import 'package:sketch/api/api.dart';
import 'dart:convert' as convert;
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WorkSpace(),
    );
  }
}

class WorkSpace extends StatefulWidget {
  const WorkSpace({Key? key}) : super(key: key);
  @override
  State<WorkSpace> createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  bool isSelecting = false;
  bool isSelecOk = false;
  Offset currentDrag = Offset(0.0,0.0);
  final GlobalKey globalKey = GlobalKey();

  Rect captureRect = Rect.zero;
  Rect pasteRect = Rect.zero;
  Offset startDrag = Offset(0, 0);
  Offset endDrag = Offset(0, 0);

  final _controller = DrawController();
  bool _isErasing = false;
  double _strokeWidth = 3.0;
  Color selectedColor = Colors.blue;

  Map<int, Uint8List> imageDatas = {};
  Image? __image ;

  final _img = AssetImage('assets/images/book.png');
  ImageInfo? imageInfo;

  void loadImage() async{
    final completer = Completer<ImageInfo>();
    final listener = ImageStreamListener((ImageInfo info, _) {
      if (!completer.isCompleted) completer.complete(info);
    });

    _img.resolve(ImageConfiguration()).addListener(listener);
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
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width *0.037,),
              IconButton(
                onPressed: (){
                  _controller.undo();
                }, icon: Icon(Icons.undo),
              ),
              IconButton(
                onPressed: (){
                  _controller.redo();
                }, icon: Icon(Icons.redo),
              ),
              IconButton(onPressed: (){
                _controller.clear();
                }, icon: Icon(Icons.takeout_dining_rounded)),
              SizedBox(width: MediaQuery.of(context).size.width*0.28,),
              IconButton(onPressed: showColorPicker, icon: Icon(Icons.draw)),
              IconButton(onPressed: (){
                setState(() {
                  _isErasing = !_isErasing;
                });
              }, icon: Icon(Icons.edit_off)),
              IconButton(onPressed: (){
                  setState(() {
                    isSelecting =! isSelecting;
                    if(isSelecting){
                      pasteRect = Rect.zero;
                    }else{
                      pasteRect = captureRect;
                    }
                    captureRect = Rect.fromPoints(Offset(0,0), Offset(0,0));
                    isSelecOk = false;
                  });
                  setState(() {
                    print("__"+isSelecting.toString());
                    print("__"+isSelecOk.toString());
                  });
              }, icon: Icon(Icons.adb)),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black,
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share)),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          AnimatedContainer(
            height: (isSelecOk && isSelecting)?MediaQuery.of(context).size.height *0.2:MediaQuery.of(context).size.height *0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              color: Colors.white38,
              child: FutureBuilder(
                  future: getImage(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageDatas.length,
                        itemBuilder: (BuildContext context,int index){
                          return Column(
                            children: [
                              Flexible(
                                  flex:10,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *0.3,
                                    width: MediaQuery.of(context).size.width *0.23,
                                    child: Card(
                                      child:!(imageDatas.length > 0)?
                                      Image.memory(imageDatas[1] as Uint8List,
                                        fit: BoxFit.contain,):
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                              image: MemoryImage(imageDatas[index]!.buffer.asUint8List()))
                                        ),
                                      ),
                                    ),
                                  )),
                              Flexible(
                                flex:1,
                                child:(index==0)?
                                Text("선택한 이미지"):
                                Text(index.toString() + "번째 이미지"),),
                            ],
                          );
                        });
                  }),
            ),
          ),
          AnimatedContainer(
            height: (isSelecOk && isSelecting)?MediaQuery.of(context).size.height *0.72:MediaQuery.of(context).size.height *0.92,
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              onPanStart :(details){
                setState(() {
                  startDrag=details.localPosition;
                  currentDrag=details.localPosition;
                });
              },
              onPanUpdate : updateDrag,
              onPanEnd: (details){
                capturePng();
                setState(() {
                  isSelecOk = true;
                  print("Select OK: "+isSelecOk.toString());
                });
              },
              child :RepaintBoundary(
                key: globalKey,
                child: Stack(
                    fit: StackFit.passthrough,
                    children:[
                      Draw(
                        controller: _controller,
                        backgroundColor: Colors.white30,
                        strokeColor: selectedColor,
                        strokeWidth: _strokeWidth,
                        isErasing: _isErasing,
                      ),
                      Positioned.fromRect(
                        rect :pasteRect,
                        child : (imageDatas.length >= 1 && !isSelecOk)?
                        Container(
                          decoration : BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:MemoryImage(imageDatas[1]!.buffer.asUint8List()),
                              //image: AssetImage('assets/images/book.png')
                            ),
                          ),
                        ):
                        Container(
                          decoration : BoxDecoration(
                            border : Border.all(
                                color: Colors.red,
                                width: 2),
                          ),
                        ),
                      ),
                      Opacity(opacity: 0.3,
                        child: Container(
                            width :MediaQuery.of(context).size.width,
                            color:(isSelecting)?Colors.white38:null,
                            height :MediaQuery.of(context).size.height
                        ),
                      ),
                      Positioned.fromRect(
                        rect :(isSelecting)?captureRect:Rect.zero,
                        child : Container(
                          decoration : BoxDecoration(
                            border : Border.all(
                                color: Colors.red,
                                width: 2),
                          ),
                        ),
                      ),
                    ],
                ),
              ),),
          ),
        ],
      ),
    );
  }

  void updateDrag(DragUpdateDetails details){
    setState(() {
      isSelecOk = false;
      currentDrag = details.localPosition;
      captureRect = Rect.fromPoints(startDrag, currentDrag);
      print("Selecting..: "+ isSelecOk.toString());
      print(currentDrag);
    });
  }

  Future<void> setImage(Uint8List _image) async {
    setState(() {
      imageDatas.addAll({0:_image});
      print("Set: "+ imageDatas[0].toString());
    });
  }

  Future<Map<int, Uint8List>> getImage() async {
    var result  = await Api().getAiSketch(imageDatas[0]!);
    print(result);
    setState(() {
      imageDatas.addAll({1:result['result']});
    });

    var _result = await {
      0:imageDatas[0] as Uint8List,
      1:result['result'] as Uint8List
    };
    return _result;
  }

  void pasteImage(){
    setState(() {
      pasteRect = captureRect;
    });
  }

  Future<void> capturePng() async {
    print("cpatuer");
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio :3);
      ByteData? byteData = await image.toByteData(format :ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      img.Image? oriImage = img.decodePng(pngBytes);

      int x=(captureRect.left*3).toInt();
      int y=(captureRect.top*3).toInt();
      int width=(captureRect.width*3).toInt();
      int height=(captureRect.height*3).toInt();

      img.Image croppedImg = img.copyCrop(oriImage!,x,y,width,height);
      // Encode the image to PNG format.
      List<int> _pngBytes = img.encodePng(croppedImg);

      // Convert the List<int> to Uint8List.
      Uint8List bytes = Uint8List.fromList(_pngBytes);
      await setImage(bytes);
      File imgFile = new File('/Users/kimjunbeom/Documents/SketchHub_front/assets/images/screenshot.png');
      imgFile.writeAsBytesSync(img.encodePng(croppedImg));
    } catch (e) {
      print(e);

    }
  }

  void showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
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