import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_radio/UI/radioImage.dart';
import 'package:the_radio/UI/sidemenu.dart';
import 'package:the_radio/config/palette.dart';
import 'package:the_radio/model/model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../PlayRadio/playradio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  bool connection = true;

  List<MyRadio> radios;

  @override
  void initState() {
    fetchRadios();
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {}
      setState(() {
        connection = false;
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Container(
            child: SideMenu(),
          ),
        ),
        appBar: AppBar(
                actions: [
                  IconButton(
                    icon: connection ? Center()
                      : Icon(CupertinoIcons.arrow_right),
                    onPressed: () { 
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RadioPlayingScreen()));
                    },
                    iconSize: 25,
                  )
                ],
                title: Text(
                  "The Radio",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5),
                ),
                backgroundColor: Palette.scaffold,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 30,
                ),
              ),
        body: connection
            ? Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/offline.png'))),
                    ),
                  ),
                ),
              )
            :  SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                child: RadioImage(),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Align(
                      child: Text(
                        "All Channels ➤",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Stack(
                      children: [
                        radios != null
                            ? VxSwiper.builder(
                                itemCount: radios.length,
                                itemBuilder: (context, index) {
                                  final rad = radios[index];

                                  return VxBox()
                                      .bgImage(DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            rad.image),
                                        fit: BoxFit.cover,
                                      ))
                                      .border(color: Colors.black, width: 2.0)
                                      .withRounded(value: 60)
                                      .make()
                                      .px24();
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.blue,
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )));
  }
}
