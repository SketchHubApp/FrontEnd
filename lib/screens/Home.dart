import 'package:flutter/material.dart';
import 'package:sketch/Utill/colors.dart';
import 'package:sketch/screens/workspace.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int MenuSize = 0;
  List<String> bookTitle = ["assets/images/Add_book.png","assets/images/book.png"] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                print(MenuSize);
                setState(() {
                  if(MenuSize == 1){
                    MenuSize = 0;
                    print(MenuSize);
                  }else{
                    MenuSize = 1;
                  }
                });
              },
              icon: Icon(Icons.menu)),
        ],
        backgroundColor: AppColors.backgroundColor,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        elevation: 0,
      ),
      body: Row(
        children: [
          Flexible(
            flex: MenuSize,
              child: Menu(context),
          ),
          Flexible(
            flex: 3,
            child: Archive(context),
          ),
        ],
      ),
    );
  }
  @override
  Widget Menu(BuildContext context){
    return AnimatedContainer(
      width: MenuSize * (MediaQuery.of(context).size.width/4),
      color: Colors.white38,
      duration: const Duration(milliseconds: 230),
    );
  }

  @override
  Widget Archive(BuildContext context){
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      //color: Colors.amber,
      duration: const Duration(milliseconds: 230),
      child: GridView.builder(
          itemCount: 2,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
          ),
          itemBuilder: (BuildContext context,int index){
            return GestureDetector(
              onTap: (){
                print("push");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkSpace()),
                );
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width *0.06,
                    MediaQuery.of(context).size.height *0.04,
                    MediaQuery.of(context).size.width *0.06,
                    MediaQuery.of(context).size.height *0.04,
                ),
                child: Card(
                  shadowColor: Colors.white30,
                  color: Colors.white,
                  child: Image.asset(bookTitle[index],
                  fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}

