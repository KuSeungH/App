import 'package:flutter/material.dart';
import 'daomodel/dbControl.dart';


void main() =>runApp(insertData());

class insertData extends StatefulWidget {

  @override
  _insertDataState createState() => _insertDataState();
}

class _insertDataState extends State<insertData> {

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _rootController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();

  final dbcontrol = DBControll();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            child:Scaffold(
                resizeToAvoidBottomInset : false,
                    appBar: AppBar(title: Text('차트')),
                    body: Container(

                      child: Column(children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: TextField(
                              controller: _titleController,
                              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Title'),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: TextField(
                              controller: _artistController,
                              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Artist'),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: TextField(
                              controller: _rootController,
                              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'root'),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: TextField(
                              controller: _imageController,
                              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Image'),
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: TextField(
                            controller: _youtubeController,
                            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'youtube'),
                          ),
                        ),

                          Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                ),

                                onPressed: (){
                                  setState(() {
                                    dbcontrol.insertMusic(_titleController.text, _artistController.text, _rootController.text, _imageController.text, _youtubeController.text);
                                  });


                                  _titleController.clear();
                                  _artistController.clear();
                                  _rootController.clear();
                                  _imageController.clear();
                                  _youtubeController.clear();
                                },
                                icon: Icon(Icons.add),
                                label: Text('음악 추가'),
                              )
                          ),


                        ]
                      )
                      )
         )
        )
    );
  }
}


