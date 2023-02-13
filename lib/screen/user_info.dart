import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:project01/screen/auth_view.dart';
import 'package:project01/screen/login_view.dart';

class UserInfo extends StatefulWidget {
  static bool isLogin = false;
  static bool isAuth = false;
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //회원가입 버튼 클릭했을시 authView페이지 나옴

    return UserInfo.isAuth
        ? authView()
        : UserInfo.isLogin
    //로그인 버튼 클릭했을시 login페이지 나옴
        ? login()
        : Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 40,
                width: 100,
                margin: EdgeInsets.only(top: 50, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                  Border.all(color: Colors.greenAccent, width: 2),
                ),
                child: InkWell(
                  //클릭 Funtion
                  onTap: () {
                    UserInfo.isAuth = true;
                    //클릭시 화면 재 렌더링

                    setState(() {});
                  },
                  child: Center(
                    child: commonText('회원 가입'),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top:150, left: 20, right: 20),
            ),
            Container(
              margin:
              EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 70,
              child: Expanded(
                  child: TextField(
                    controller: id,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'ID',
                      hintText: 'Enter your ID',
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.pinkAccent),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.greenAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.pinkAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    keyboardType: TextInputType.text,

                  )),
            ),

            Container(
              margin:
              EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 70,
              child: Expanded(
                  child: TextField(
                    controller: pw,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'PW',
                      hintText: 'Enter your PW',
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.pinkAccent),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.greenAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.pinkAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    keyboardType: TextInputType.text,

                  )),
            ),
            InkWell(
                onTap: () async {
                  //디비 Path가져오기
                  final databasePath = await getDatabasesPath();
                  String path = join(databasePath, 'my_database.db');
                  //디비 접속 하기
                  var db = await openDatabase(
                    path,
                    version: 1,
                    onConfigure: (Database db) => {},
                    onCreate: (Database db, int version) => {
                      db.execute('''  CREATE TABLE users(
                                 No INTEGER PRIMARY KEY AUTOINCREMENT,
                                   id TEXT,
                                   pw TEXT,
                                    nick DATETIME)
                                   ''')
                    },
                    onUpgrade: (Database db, int oldVersion,
                        int newVersion) =>
                    {},
                  );
                  //users Table에 접속하여 해당값들 가져오기
                  final List<Map<String, dynamic>> maps =
                  await db.query('users');
                  bool login = false;
                  //저장되어있는 DB에서 id,pw 확인후 둘다 같을경우 isLogin을 true로 바꾸어 로그인 화면 띄우기
                  for (Map sql in maps) {
                    print(sql);
                    if (sql['id'] == id.text &&
                        sql['pw'] == pw.text) {
                      db.execute('''	 SELECT nick FROM users WHERE id='id' ''');
                      UserInfo.isLogin = true;

                      break;
                    }
                  }
                  //화면 재 렌더링
                  setState(() {});
                },

                child: Container(
                  width: 200,
                  height: 40,
                  margin:
                  const EdgeInsets.only(top:20, left: 20, right: 20),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent
                  ),
                  child: Center(
                    child: commonText('로그인'),
                  ),

                ))
          ]),
    );
  }



  commonText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
  }
}
