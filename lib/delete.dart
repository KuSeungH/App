import 'package:flutter/material.dart';
import 'package:project01/vomodel/musicVO.dart';
import 'daomodel/dbControl.dart';

void main() =>runApp(deleteData());

class deleteData extends StatefulWidget {

  @override
  _deleteDataState createState() => _deleteDataState();
}


class _deleteDataState extends State<deleteData> {

  final dbcontrol = DBControll();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Container(

        child: Scaffold(
          appBar:AppBar(
          title: Text('사원관리 북'),
          centerTitle: true,
          ),

        body: Container(

          child: Column( children: <Widget>[
            Expanded(

            child: FutureBuilder(

              future: dbcontrol.getAllMusic(),
              builder: (context, snap){

                List<Music> musicList = snap.data as List<Music>;

                if(!snap.hasData){
                  // !snap.hasData는 자료가 없는경우(입력한게 없는경우)
                  return Center(
                    child: Text('자료없음'),
                  );
                }

                return Scrollbar(

                    thickness: 10.0,
                    // radius: Radius.circular(8.0),
                    isAlwaysShown: true,

                  child:ListView.builder(


                  itemCount: musicList.length,
                  itemBuilder: (context, idx){

                    return Card(

                      elevation: 3,
                      child: ListTile(
                        leading:Image.asset('${musicList[idx].image}', width: 50, height: 50),
                        title: Text('${musicList[idx].title}'),
                        subtitle: Text('${musicList[idx].artist}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: (){
                                setState(() {
                                  dbcontrol.deleteEmp(musicList[idx].id);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                 )
                );
              },
            ),
          )
      ]
        ),
       ),
      )
    ),
    );
  }
}