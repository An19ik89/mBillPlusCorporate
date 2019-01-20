import "package:flutter/material.dart";
import 'package:mbillpluscorporate/usermenu/register_page.dart';

class Promotions extends StatefulWidget {
  final String title;
  Promotions(this.title);
  @override
  PromotionsState createState() => new PromotionsState();
}

class PromotionsState extends State<Promotions> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Promotions"),
      ),
      body: new Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[Text("Promotions")],
            )
          ],
        ),
      ),
    );
  }
}



