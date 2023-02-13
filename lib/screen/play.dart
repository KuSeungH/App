import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Play extends StatefulWidget {

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        home: Container(
            child: Scaffold(
            appBar:AppBar(
            title: Text('${Get.arguments['title']}'),
            ),
          )
        )
    );
  }
}