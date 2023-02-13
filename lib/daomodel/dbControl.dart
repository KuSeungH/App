import '../vomodel/musicVO.dart';
import 'musicDAO.dart';


class DBControll {

  // 전체사원명단 return, DAO의 R작업수행
  Future<List<Music>> getAllMusic() async {
    final musicsList = await DatabaseHelper.getMusics('musict');

    return musicsList.map((item) =>
        Music(
            id: item['id'] as String,
            title: item['title'] as String,
            artist: item['artist'] as String,
            root: item['root'] as String,
            image: item['image'] as String,
            youtube: item['youtube'] as String)).toList();
  }


  // insert
  void insertMusic(String title, String artist, String root, String image,String youtube) {
    DatabaseHelper.insertMusic('musict', {
      'id': DateTime.now().toString(),
      'title': title,
      'artist': artist,
      'root': root,
      'image': image,
      'youtube' :youtube
    });
  }

  // delete
  void deleteEmp(String id) {
    DatabaseHelper.deleteMusic('musict', id);
  }
}
