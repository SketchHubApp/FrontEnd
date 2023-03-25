import 'package:flutter/material.dart';
import 'package:sketch/Utill/colors.dart';
import 'package:flutter_login/flutter_login.dart';

import 'Home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _pwFocus = FocusNode(); // pw 포커스
  Color autoLoginButtonColor = Colors.blueAccent;
  bool autoLogin = true;
  String? email = null;
  String? password = null;
  Map<String,dynamic> idpw={};
  Color mint  = Colors.black;
  Color r_color = Colors.black;
  bool flage = false;
  double _width = 0.0;
  double _hight = 0.0;
  String titleName = "Let's Start";
  int a = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: AppColors.backgroundColor,
          child: Center(
            child: Column(
              children: [
                Flexible(
                  flex: 2 * a,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: MediaQuery.of(context).size.height * 0.3 * a,
                    ),
                ),
                Flexible(
                  flex: 4,
                  child: AnimatedContainer(
                    height: MediaQuery.of(context).size.height,
                    duration: const Duration(seconds: 1),
                    child: Image.asset("assets/images/Logo_notBack.png",
                    fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    width: _width,
                    height: _hight,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: Login(context),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: (){
                      setState(() {
                        flage = !flage;
                        if(flage){
                          titleName = "END";
                          _width = 500.0;
                          _hight = 300.0;
                          a = 0;
                        }else{
                          titleName = "Let's Start";
                          _width = 0.0;
                          _hight = 0.0;
                          a = 1 ;
                        }
                      });
                    },
                    child: Text(titleName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget Login(BuildContext context){
    return Container(
      height: 600,
      width: 500,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              child: Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 400,
                          height: 75,
                          child: Theme(
                            data: new ThemeData(
                                hintColor: Colors.black,
                            ),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              textInputAction: TextInputAction.next,
                              decoration: new InputDecoration(
                                labelStyle: TextStyle(
                                    color: Colors.black),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: 1, color: r_color)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      width: 3, color: mint),
                                ),
                                labelText: '아이디 입력',
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: 2, color: r_color)),
                              ),
                              onSaved: (String? value) {
                                email = value!;
                              },
                              //validator: LoginControl().validateEmail,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context)
                                    .requestFocus(_pwFocus);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 400,
                            height: 75,
                            child: Theme(
                              data: new ThemeData(
                                hintColor: Colors.white,
                              ),
                              child: TextFormField(
                                // 숫자 입력 키보드
                                cursorColor: r_color,
                                focusNode: _pwFocus,
                                // 포커스 생성
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                                textInputAction: TextInputAction.done,
                                // 엔터키 텍스트
                                obscureText: true,
                                decoration: new InputDecoration(
                                  labelStyle: TextStyle(
                                      color:
                                      Colors.black),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          width: 1, color: r_color)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: 2, color: r_color),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          width: 1, color: r_color)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: 3, color: r_color),
                                  ),
                                  labelText: '비밀번호 입력',
                                ),

                                onSaved: (String? value) {
                                  password = value!;
                                },
                                //validator: LoginControl().validatePassword,
                                onFieldSubmitted: (temp) async {},
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 200 ,
                              height: 55 ,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 7.0, left: 2.0),
                                child: GestureDetector(

                                  onDoubleTap: () {},
                                  onTap: () {},
                                  child: ElevatedButton(
                                      // style: ButtonStyle(
                                      //   shape: RoundedRectangleBorder(
                                      //       borderRadius:
                                      //       BorderRadius.circular(8)),
                                      //   color: Colors.blue,
                                      // ),
                                    onPressed: () async {
                                      print("Login");
                                      // if (_formKey.currentState!
                                      //     .validate()) {
                                      //   _formKey.currentState!.save();
                                      //   // 키보드 닫기 => 에러 수정해야함 로그인 실패시 예외처리
                                      //   FocusScope.of(context)
                                      //       .requestFocus(FocusNode());
                                      //
                                      //   Future.delayed(
                                      //       Duration(milliseconds: 500),
                                      //           () async {
                                      //         await LoginControl().requestLogin(context,
                                      //             email, password,
                                      //             autoLoginPermission:
                                      //             autoLogin,
                                      //             type: 2);
                                      //       });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => HomeScreen()),
                                        );
                                      // }
                                    },
                                    child: Text("로그인",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                          20,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Container(),
                              ),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 15.0),
                                  child: InkWell(
                                    child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(children: <Widget>[
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: autoLoginButtonColor,
                                            size:
                                            25,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, bottom: 2.0),
                                            child: Container(
                                              child: Text("자동 로그인",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  )),
                                            ),
                                          )
                                        ])),
                                    onTap: () {
                                      autoLogin == true
                                          ? autoLogin = false
                                          : autoLogin = true;
                                      setState(() {
                                        autoLogin == true
                                            ? autoLoginButtonColor =
                                            Colors.teal
                                            : autoLoginButtonColor =
                                            Colors.black;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

