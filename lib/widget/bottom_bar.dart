import 'package:flutter/material.dart';

class Bottom extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,

      child: Container(
        child: TabBar(
          labelColor: Colors.pinkAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.transparent,

          tabs:<Widget>[

            Tab(icon: Icon(//검색
                Icons.search),
              child: Text('Search', style: TextStyle(fontSize: 10),
              ),
            ),
            Tab(icon: Icon( // 홈
                Icons.home),
              child: Text('Home', style: TextStyle(fontSize: 10),
              ),
            ),
            Tab(icon: Icon(
                Icons.person),
              child: Text('Login', style: TextStyle(fontSize: 10),
              ),
            ),

          ],
        ),
      ),
    );

  }
}