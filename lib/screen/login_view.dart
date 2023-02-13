import 'package:flutter/material.dart';
import 'package:project01/main.dart';
import 'package:project01/screen/user_info.dart';

import 'package:flutter/material.dart';

class login extends StatefulWidget {
  _login createState() => _login();
  static bool isLogout = false;

}

class _login extends State<login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return login.isLogout
        ? UserInfo()
        : Scaffold(
      // bottomNavigationBar: Bottom(),
        backgroundColor: Colors.white,
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 40,
            margin: EdgeInsets.only(top: 50, right: 20, left: 20),
            decoration:
            BoxDecoration(border: Border.all(color: Colors.greenAccent, width: 2)),
            child: Center(
              child: commonText('하나씨 환영합니다.'),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(top:350, left: 20, right: 20),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 40,
              width: 200,
              margin: EdgeInsets.only(top: 50, right: 90),
              decoration: BoxDecoration(
                  border:
                  Border.all(color: Colors.greenAccent, width: 2)),
              child: InkWell(
                //클릭 Funtion
                onTap: () {
                  UserInfo.isLogin = false;
                  login.isLogout = true;
                  //클릭시 화면 재 렌더링
                  setState(() {});
                },

                child: Center(
                  child: commonText('로그아웃'),
                ),
              ),
            ),
          ),
        ])
    );

  }



  commonText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
  }
}
