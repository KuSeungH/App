import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter/material.dart';
// 만일 null safety에러 나서 빌드 안되면
// run-edit configuration - 해당 다트 파일 - additional run args:에서
// --no -sound-null-safety 입력
void main() {
  runApp(const Mp());
}

class Mp extends StatelessWidget {
  const Mp({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '가자 플러터',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: '스와이퍼'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super (key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> imgList = [
    'img/LoveYourself.jpg',
    'img/Stay.jpg',
    'img/Ditto.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: 250,
        child: Padding(
          padding: EdgeInsets.all(10),

          child: Swiper(
            // swiper의 추가 구성
              autoplay: true, // 자동넘김
              scale: 1.1, // 이미지 겹침
              viewportFraction: 0.8, // 전체적인 크기
              pagination:  SwiperCustomPagination(
                // https://pub.dev/documentation/flutter_swipwe/latest/flutter_swiper/Swiper
                // 페이지 매기기 (점으로)

              ),
              itemCount: imgList.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(imgList[index]);
              }
          ),
        ),
      ),
    );
  }
}

//
// final List<String> imgList =[
//   'img/car1.png',
//   'img/car2.png',
//   'img/car3.png',
// ];
//
// return Image.asset(imgList[index]); // 4. 이미지 출력방식(asset, 만약 url로한다면 network)