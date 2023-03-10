import 'package:sqflite/sqflite.dart' as dbdb;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';


class DatabaseHelper {
  // Databasehelper는 user-defined, 주로 DBHelper

  static Future<Database> database() async {
    final dbpath = await dbdb.getDatabasesPath(); // DB의 경로를 알아내는 메소드
    return dbdb.openDatabase( // DB를 open하는 메소드, 이때 인자로 DB의 path를 가리켜야 함
      // 근데 위에서 구한 dbpath는 DB의 경로가 아닌 DB가 있는 폴더의 경로
      // 그래서 path를 사용해서 dbpath와 musicdb.db를 결합시켜주면 db의 경로가 완성, 이걸 인자로 쓰면 된다.
        path.join(dbpath, 'userdb.db'),
        // path plagin은 파일을 결합하는 메소드, 'musicdb.db'는 sqlite의 db이름, 스마트폰에 이 db가 들어감(테이블 x)

        onCreate: (db,
            version) { // onCreate는 DB가 생성될 때 실행되는 콜백, DB가 실행되자마자 table을 만들도록 설정
          return db.execute(
              '''CREATE TABLE usert(id TEXT PRIMARY KEY, title TEXT, artist TEXT, root TEXT, image TEXT)'''); // 테이블 생성
        },
        version: 1 // 이건 DB버전

    ); // musicdb.db 라는 DB안에 musict라는 테이블이 생성됨
  }

}