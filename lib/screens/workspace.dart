import 'package:flutter/material.dart';
import 'package:draw_your_image/draw_your_image.dart';
import 'package:web_socket_channel/status.dart';
import '../Utill/colors.dart';

class WorkSpace extends StatefulWidget {
  const WorkSpace({Key? key}) : super(key: key);
  @override
  State<WorkSpace> createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  final _controller = DrawController();
  bool _isErasing = false;
  double _strokeWidth = 3.0;

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
              IconButton(onPressed: (){
                _showMyDialog("penc",context);
                }, icon: Icon(Icons.draw)),
              IconButton(onPressed: (){
                //_showMyDialog("eras",context);
                setState(() {
                  _isErasing = !_isErasing;
                });
              }, icon: Icon(Icons.edit_off)),
              IconButton(onPressed: (){
                //_showMyDialog("AI",context);
                setState(() {
                  _isErasing = !_isErasing;
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
      body: Draw(
          controller: _controller,
          backgroundColor: Colors.white30,
          strokeColor: Colors.black,
          strokeWidth: _strokeWidth,
          isErasing: _isErasing,
          onConvertImage: (imageData) {
            // do something with imageData
          }
      ),
    );
  }

  Future<void> _showMyDialog(String type, BuildContext context){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          title: Text(type.toString()),
          content: type == 'penc'? _pentool() : type == 'eras'? _eras() : _aitool(),
          actions: <Widget>[
            TextButton(
              child: const Text('Check'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget _pentool(){
    double _currentSliderValue = 0.0;
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: Slider(
                value: _currentSliderValue,
                max: 100.0,
                divisions: 10,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                   setState((){
                     _currentSliderValue = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height:  MediaQuery.of(context).size.height * 0.023,
          ),// 크기 실린더
          Flexible(
            flex: 3,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: (){},
                      minWidth: 35.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),//모서리
                          ), //테두리
                      color: Colors.red,
                    ),
                    MaterialButton(
                      onPressed: (){},
                      minWidth: 35.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),//모서리
                      ), //테두리
                      color: Colors.green,
                    ),
                    MaterialButton(
                      onPressed: (){},
                      minWidth: 35.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),//모서리
                      ), //테두리
                      color: Colors.blue,
                    ),
                    MaterialButton(
                      onPressed: (){},
                      minWidth: 35.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),//모서리
                      ), //테두리
                      color: Colors.amber,
                    ),
                    MaterialButton(
                      onPressed: (){},
                      minWidth: 35.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),//모서리
                      ), //테두리
                      color: Colors.indigo,
                    ),
                    MaterialButton(
                      onPressed: (){},
                      minWidth: 35.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),//모서리
                      ), //테두리
                      color: Colors.white24,
                    ),
                    MaterialButton(
                      onPressed: (){},
                      minWidth: 35.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),//모서리
                      ), //테두리
                      color: Colors.teal,
                    ),
                    MaterialButton(
                      onPressed: (){},
                      minWidth: 35.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),//모서리
                      ), //테두리
                      color: Colors.pink,
                    ),
                    IconButton(
                        onPressed: (){},
                        disabledColor:Colors.black,
                        icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
          ), // 컬러 선택
        ],
      ),
    );
  }

  @override
  Widget _aitool(){
    return Container();
  }

  @override
  Widget _eras(){
    return Container();
  }
}
