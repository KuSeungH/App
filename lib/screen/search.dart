import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project01/daomodel/dbControl.dart';
import 'package:project01/vomodel/musicVO.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final dbcontroller = DBControll();



  late List<Music> main_music_list = [];
  //Ditto, 2002, 전체를 담는 그릇
  late List<Music> display_list = [];
  //검색된 것들 d, 2 등등
  void updateList(String value){
    setState(() {
      display_list = main_music_list.where((element) => element.title.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        body:
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search for a music",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:22.0,
                    fontWeight:FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder( //future를 떼기위해서
                  future: dbcontroller.getAllMusic(), //db에 있는 거 전체 다 불러오기 //future를 달고 온다
                  builder: (conxtext3, snap) {

                    main_music_list = snap.data as List<Music>;
                    // 전체 조회한 거 담아  ㄴ 떼는 작업하기 위해서 FutureBuilder를 써야함
                    return TextField(
                      onChanged: (value) => updateList(value),
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0XFF69F0AE),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "검색어를 입력하세요",
                        hintStyle: TextStyle(color: Colors.pinkAccent),
                        prefixIcon: Icon(Icons.search, color: Colors.pinkAccent),

                      ),
                      cursorColor: Colors.pinkAccent,
                    );
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: display_list.length,
                        itemBuilder: (context3, idx) {
                          return Card(
                            color: Colors.white,
                            elevation: 3,
                            child: ListTile(
                              leading:Image.asset('${display_list[idx].image}', width: 50, height: 50),
                              title: Text('${display_list[idx].title}',style: TextStyle(color: Colors.black),),
                              subtitle: Text('${display_list[idx].artist}',style: TextStyle(color: Colors.grey),),
                              trailing: IconButton(
                                icon: Icon(Icons.arrow_right_sharp),
                                color: Colors.greenAccent,
                                iconSize: 40.0,
                                onPressed: (){
                                  Get.toNamed('/playScreen', arguments: {'image': '${display_list[idx].image}', 'title': '${display_list[idx].title}',
                                    'artist': '${display_list[idx].artist}', 'root': '${display_list[idx].root}'}
                                  );
                                },
                              ),
                            ),
                          );
                        }
                    )

                ),
              ]),
        ),

    );
  }
}