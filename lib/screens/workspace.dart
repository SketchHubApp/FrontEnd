import 'package:flutter/material.dart';
import 'package:draw_your_image/draw_your_image.dart';
import '../Utill/colors.dart';

class WorkSpace extends StatefulWidget {
  const WorkSpace({Key? key}) : super(key: key);

  @override
  State<WorkSpace> createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  final _controller = DrawController();
  bool _isErasing = false;
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
              IconButton(onPressed: (){}, icon: Icon(Icons.add)),
              SizedBox(width: MediaQuery.of(context).size.width*0.28,),
              IconButton(onPressed: (){
                _showMyDialog("penc");
              }, icon: Icon(Icons.draw)),
              IconButton(onPressed: (){
                _showMyDialog("color");
              }, icon: Icon(Icons.palette)),
              IconButton(onPressed: (){
                _showMyDialog("eras");
                setState(() {
                  _isErasing = !_isErasing;
                });
              }, icon: Icon(Icons.edit_off)),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black,
        ),
        elevation: 0,
      ),
      body: Draw(
          controller: _controller,
          backgroundColor: Colors.white30,
          strokeColor: Colors.black,
          strokeWidth: 3,
          isErasing: _isErasing,
          onConvertImage: (imageData) {
            // do something with imageData
          }
      ),
    );
  }
  Future<void> _showMyDialog(String type){
    double _currentSliderValue = 2.0;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          title: Text(type.toString()),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.02,
            child: Slider(
              value: _currentSliderValue,
              max: 100,
              divisions: 50,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
          ),
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
}
