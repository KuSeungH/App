import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Player extends StatefulWidget {
  String? nullable;
  String? get title => '${Get.arguments['title']}';
  String? get youtube => '${Get.arguments['youtube']}';

  @override
  PlayerState createState() => PlayerState();
}

class PlayerState extends State<Player> {
  String? nullable;
  String? get title => '${Get.arguments['title']}';
  String? get youtube => '${Get.arguments['youtube']}';
  PlayerState();
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: youtube!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          title!,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: YoutubePlayer(
        key: ObjectKey(_controller),
        controller: _controller,
        actionsPadding: const EdgeInsets.only(left: 16.0),
        bottomActions: [
          CurrentPosition(),
          const SizedBox(width: 10.0),
          ProgressBar(isExpanded: true),
          const SizedBox(width: 10.0),
          RemainingDuration(),
          //FullScreenButton(),
        ],
      ),
    );
  }
}
/*
TextButton(
onPressed: () {
Route route = MaterialPageRoute(builder: (context) => MyApp());
Navigator.pushReplacement(context, route);
},
child: Text('◁'),
),*/
