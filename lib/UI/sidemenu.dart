import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_radio/UI/privacy.dart';
import 'package:the_radio/UI/terms.dart';
import 'package:the_radio/model/model.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
    return Container(
        child: ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Text(
            'Hello Music Lovers!!!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        ),
        Divider(),
        ListTile(
          title: Text(
            'GitHub',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          trailing: Icon(MdiIcons.github),
          onTap: () async {
            const url = 'https://github.com/SamwitAdhikary';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            'Terms And Condition',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          trailing: Icon(MdiIcons.pen),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsAndCondition(),
                ));
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          trailing: Icon(MdiIcons.note),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicy(),
                ));
          },
        ),
        Divider(),
        // ListTile(
        //   title: Text(
        //     'Share This App',
        //     style: TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        //   contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        //   trailing: Icon(Icons.share),
        //   onTap: () => Share.share('http://bit.ly/the_radio'),
        // ),
        // Divider(),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Text(
            'Made With ❤️ in\nIndia',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        )
      ],
    ));
  }
}
