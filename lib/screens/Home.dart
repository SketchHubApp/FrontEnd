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
  bool RecentMenuSize = false;
  bool SharMenuSize = false;
  List<String> bookTitle = ["assets/images/Add_book.png","assets/images/book.png"] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                RecentMenuSize = false;
                SharMenuSize = false;
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
        iconTheme: const IconThemeData(color: Colors.white),
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
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.1,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                          Text("최근 탭"),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.13,),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                RecentMenuSize = !RecentMenuSize;
                              });
                            },
                            icon: Icon(Icons.unfold_more_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),//최근 탭
          ),
          RecentList(context),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Row(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                        Text("공유 탭"),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.13,),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              SharMenuSize = !SharMenuSize;
                            });
                          },
                          icon: Icon(Icons.unfold_more_rounded),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),//최근 탭
          ),
          SharList(context),
        ],
      ),
    );
  }
  @override
  Widget Archive(BuildContext context){
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 230),
      child: GridView.builder(
          itemCount: 2,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
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
  @override
  Widget RecentList(BuildContext context){
    int listIndex = 5;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 230),
      color: Colors.red,
      height: RecentMenuSize ? MediaQuery.of(context).size.height * 0.05 * listIndex : 0, // x listIndex
      width: RecentMenuSize ? MediaQuery.of(context).size.width * 0.24 : 0,
    );
  }
  @override
  Widget SharList(BuildContext context){
    int listIndex = 1;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 230),
      color: Colors.black,
      height: SharMenuSize ? MediaQuery.of(context).size.height * 0.05 * listIndex : 0, // x listIndex
      width: SharMenuSize ? MediaQuery.of(context).size.width * 0.24 : 0,
    );
  }
}

