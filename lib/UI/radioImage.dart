import 'package:flutter/material.dart';

class RadioImage extends StatefulWidget {
  @override
  _RadioImageState createState() => _RadioImageState();
}

class _RadioImageState extends State<RadioImage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.49,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/image.jpg",
              ), 
              fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(50)),
    );
  }
}
