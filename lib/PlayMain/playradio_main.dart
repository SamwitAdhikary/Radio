import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_radio/config/palette.dart';
import 'package:the_radio/model/model.dart';

class PlayRadioMain extends StatefulWidget {
  final MyRadio myRadio;
  PlayRadioMain(this.myRadio);

  @override
  _PlayRadioMainState createState() => _PlayRadioMainState(myRadio);
}

class _PlayRadioMainState extends State<PlayRadioMain> {
  MyRadio myRadio;
  _PlayRadioMainState(this.myRadio);
  // String audioState;
  bool _isPlaying = false;

  final assetsAudioPlayer = AssetsAudioPlayer();

  playAudio() async {
    await assetsAudioPlayer.open(
        Audio.liveStream(myRadio.url,
            metas: Metas(
                title: myRadio.name,
                artist: myRadio.tagline,
                image: MetasImage.network(myRadio.image))),
        showNotification: true,
        playInBackground: PlayInBackground.enabled,
        audioFocusStrategy: AudioFocusStrategy.request(
          resumeAfterInterruption: true,
          resumeOthersPlayersAfterDone: true,
        ),
        notificationSettings: NotificationSettings(
          prevEnabled: false,
          nextEnabled: false,
        ),
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug);
    setState(() {
      _isPlaying = true;
    });
  }

  stopAudio() {
    assetsAudioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  // ignore: missing_return
  Future<bool> _onBackPressed() {
    if (_isPlaying == true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Going back will stop the music.'),
              actions: [
                FlatButton(
                  child: Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('YES'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    stopAudio();
                  },
                )
              ],
            );
          });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.scaffold,
        elevation: 0,
        title: Text(
          myRadio.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
            stopAudio();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: WillPopScope(
              onWillPop: _onBackPressed,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 15.0, // soften the shadow
                              spreadRadius: 1.0, //extend the shadow
                              offset: Offset(
                                10.0, // Move to right 10  horizontally
                                10.0, // Move to bottom 5 Vertically
                              ),
                            )
                          ],
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(myRadio.image),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: _isPlaying
                                ? Lottie.asset('assets/audio.json')
                                : Container(
                                    child: Text(
                                      'Just Click And Wait!!',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(_isPlaying
                                    ? CupertinoIcons.stop_circle
                                    : CupertinoIcons.play_circle),
                                onPressed: () {
                                  _isPlaying ? stopAudio() : playAudio();
                                },
                                iconSize: 80,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
