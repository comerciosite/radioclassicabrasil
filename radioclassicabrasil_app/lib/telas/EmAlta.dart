import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';

class EmAlta extends StatefulWidget {
  var playerState = FlutterRadioPlayer.flutter_radio_paused;

  var volume = 0.8;

  @override
  _EmAltaState createState() => _EmAltaState();
}

class _EmAltaState extends State<EmAlta> {
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();

  @override
  void initState() {
    super.initState();
    initRadioService();
  }

  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init("Rádio Clássiva Brasil", "#AoVivo",
          "https://streaming.livebroadcast.biz/radio/8010/classica", "true");
    } on PlatformException {
      print("Exception occured while trying to register the services.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Rádio Clássica Brasil'),
        backgroundColor: Colors.teal,

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("imagens/logoradioclassica.png"),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        stream: _flutterRadioPlayer.isPlayingStream,
                        initialData: widget.playerState,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          String returnData = snapshot.data;
                          print("object data: " + returnData);
                          switch (returnData) {
                            case FlutterRadioPlayer.flutter_radio_stopped:
                              return RaisedButton(
                                  child: Text("Comece a ouvir agora"),
                                  onPressed: () async {
                                    await initRadioService();
                                  });
                              break;
                            case FlutterRadioPlayer.flutter_radio_loading:
                              return Text("Carregando fluxo...");
                            case FlutterRadioPlayer.flutter_radio_error:
                              return RaisedButton(
                                  child: Text("Repetir ?"),
                                  onPressed: () async {
                                    await initRadioService();
                                  });
                              break;
                            default:
                              return Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                        onPressed: () async {
                                          print("button press data: " +
                                              snapshot.data.toString());
                                          await _flutterRadioPlayer
                                              .playOrPause();
                                        },
                                        icon: snapshot.data ==
                                            FlutterRadioPlayer
                                                .flutter_radio_playing
                                            ? Icon(Icons.pause, size: 50)
                                            : Icon(Icons.play_arrow, size: 50)),
                                    IconButton(
                                        onPressed: () async {
                                          await _flutterRadioPlayer.stop();
                                        },
                                        icon: Icon(Icons.stop, size: 50))
                                  ]);
                              break;
                          }
                        }),
                    Slider(
                        value: widget.volume,
                        min: 0,
                        max: 1.0,
                        onChanged: (value) =>
                            setState(() {
                              widget.volume = value;
                              _flutterRadioPlayer.setVolume(widget.volume);
                            })),
                    Text(
                        "Volume: " + (widget.volume * 100).toStringAsFixed(0))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "ClássicaBrasil.com - Itapema,SC",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "App Desenvolvido por: livebroadcast.com",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
