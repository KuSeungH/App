import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project01/daomodel/dbControl.dart';
import 'package:project01/screen/playScreen.dart';
import 'package:project01/screen/youtube.dart';
import 'package:project01/vomodel/musicVO.dart';


void main(){
  runApp(Home());
}


class Home extends StatelessWidget {
  bool a = true;
  final dbcontrol = DBControll();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

        initialRoute: '/',
        getPages: [
          GetPage(name: '/playScreen', page: () => PlayScreen()),
          GetPage(name: '/youtube',page: () => Player())
        ],


        home: Container(
          child:Scaffold(
              appBar: AppBar(title: Text('차트')),
              body: Container(

                  child: Column(children: <Widget>[
                    // 전체음악리스트 출력
                    Expanded(

                        child: FutureBuilder(

                            future: dbcontrol.getAllMusic(),
                            builder: (context3, snap) {

                              List<Music> musicList = snap.data as List<Music>;

                              if (!snap.hasData) {
                                // !snap.hasData는 자료가 없는경우(입력한게 없는경우)
                                return Center(
                                  child: Text('자료없음'),
                                );
                              }

                              return ListView.builder(

                                  itemCount: musicList.length,
                                  itemBuilder: (context3, idx) {
                                    return Card(
                                      elevation: 3,
                                      child: ListTile(
                                        leading:Image.asset('${musicList[idx].image}', width: 50, height: 50),
                                        title: Text('${musicList[idx].title}'),
                                        subtitle: Text('${musicList[idx].artist}'),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(icon: Icon(Icons.arrow_right_sharp),
                                            color: Colors.greenAccent,
                                            iconSize: 45.0,
                                            onPressed: (){
                                              Get.toNamed('/playScreen', arguments: {'image': '${musicList[idx].image}', 'title': '${musicList[idx].title}',
                                                'artist': '${musicList[idx].artist}', 'root': '${musicList[idx].root}'});
                                            },
                                          ),
                                            IconButton(
                                              icon:
                                              Icon(Icons.video_collection),
                                              color: Colors.red,
                                              iconSize: 30.0,
                                                onPressed: (){
                                                  Get.toNamed('/youtube', arguments: {'title': '${musicList[idx].title}', 'youtube':  '${musicList[idx].youtube}'});
                                                  },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                            }
                        )

                    )]
                  )
              )
          ),
        )
    );
  }
}


