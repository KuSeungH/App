import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayScreen extends StatefulWidget {

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2,'0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}

class _PlayScreenState extends State<PlayScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying =true;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String title = '${Get.arguments['title']}';
  String artist = '${Get.arguments['artist']}';
  String root = '${Get.arguments['root']}';
  String image = '${Get.arguments['image']}';

  @override
  void initState() {
    super.initState();
    audioPlayer.resume();
    setAudio();

    //playing, paused, stop
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    //지속
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    final player = AudioCache(prefix: 'img/');
    final url = await player.load(root);
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
        children: [
          Image.asset(
            "img/watermelon.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          child: Container(
            color: Colors.black.withOpacity(0.7),
          ),
          ),
          Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      iconSize: 50,
                      onPressed: (){
                        Get.back();
                        audioPlayer.pause();
                      },
                      icon: Icon(Icons.chevron_left))

              ),

              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(image,
                  width: 250,
                  height: 300,
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                artist,
                style: TextStyle(fontSize: 20),
              ),
              Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                activeColor: Colors.pinkAccent,
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await audioPlayer.seek(position);

                  await audioPlayer.resume();
                },
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatTime(position)),
                    Text(formatTime(duration - position)),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 35,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  iconSize: 50,
                  onPressed: () async {
                    if(isPlaying){
                      await audioPlayer.pause();
                    }else{
                      await audioPlayer.resume();
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),),
        );
  }

}
