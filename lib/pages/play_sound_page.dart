import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlaySoundPage extends StatefulWidget {
  String title;

  PlaySoundPage({required this.title});

  @override
  State<PlaySoundPage> createState() => _PlaySoundPageState();
}

class _PlaySoundPageState extends State<PlaySoundPage> {
  AudioPlayer player = AudioPlayer();
  late AssetSource source;

  @override
  void initState() {
    super.initState();
    initialiserSon();
  }

  initialiserSon() async {
    String audioasset = "audio/app_sound.mp3";
    source = AssetSource(audioasset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            buttonJouerSon(context),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  buttonJouerSon(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10)),
              onPressed: () async {
                await player.play(
                  source,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Jouer du Son',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
