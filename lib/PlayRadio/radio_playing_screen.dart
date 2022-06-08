import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_radio/PlayMain/playradio_main.dart';
import 'package:the_radio/config/palette.dart';
import 'package:the_radio/model/radio.dart';

class RadioPlayingScreen extends StatefulWidget {
  @override
  _RadioPlayingScreenState createState() => _RadioPlayingScreenState();
}

class _RadioPlayingScreenState extends State<RadioPlayingScreen> {
  List<MyRadio> radios;
  
  @override
  void initState() {
    super.initState();
    fetchRadios();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Play Radio",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Palette.scaffold,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: radios != null
              ? ListView.builder(
                  itemCount: radios.length,
                  itemBuilder: (BuildContext context, int i) {
                    final rad = radios[i];

                    return Card(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayRadioMain(rad)));
                          },
                          leading: CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(rad.image),
                            radius: 24,
                          ),
                          title: Text(
                            rad.name,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          trailing: IconButton(
                            icon: new Icon(CupertinoIcons.play),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PlayRadioMain(rad)));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
