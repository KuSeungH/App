import 'package:flutter/material.dart';
import 'package:project01/screen/home.dart';
import 'package:project01/screen/search.dart';




import '../screen/user_info.dart';
import '../widget/bottom_bar.dart';

void main() =>runApp(MyApp());

class MyApp extends StatefulWidget{
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'WaterMelon',
      theme:ThemeData(

        brightness:Brightness.dark,//명도
        primaryColor: Colors.green,//아이덴티티색
        accentColor:Colors.pink, //인풋값(체크박스나,라디오버튼)눌렀을때 색
      ),
      debugShowCheckedModeBanner: false, // 상단바 debug 제거

      home: DefaultTabController(
        length: 3,//홈화면,플레이리스트,검색,회원가입,로그인
        child: Scaffold(
          backgroundColor: Colors.white,
          body: TabBarView(
            physics:ClampingScrollPhysics (), // 이거는 정상기능, NeverScrollableScrollPhysics():손가락 모션으로 스크롤하는걸 막는기능
            children:<Widget> [
               // length: 4,니까 컨테이너 4개

              SearchPage(),
              Container(child:Home()),
              UserInfo(),
            ],
          ),
          bottomNavigationBar: Bottom(),//바텀바
        ),
      ),
    );
  }
}