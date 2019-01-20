import 'package:flutter/material.dart';
import 'package:mbillpluscorporate/appbar/navbar.dart';
import 'package:mbillpluscorporate/usermenu/message_page.dart';
import 'package:mbillpluscorporate/usermenu/payment_page.dart';
import 'package:mbillpluscorporate/usermenu/promotion_page.dart';
import 'package:mbillpluscorporate/usermenu/report_page.dart';
import 'package:mbillpluscorporate/usermenu/requiestion_page.dart';
import 'package:mbillpluscorporate/usermenu/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  final String title;
  DashBoard(this.title);
  @override
  DashBoardPageState createState() => new DashBoardPageState();
}

class DashBoardPageState extends State<DashBoard> {
  String spStrMobileNumber="";

  Future<String> getSortingOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    spStrMobileNumber = prefs.getString("MobileNumber");
    return spStrMobileNumber;
  }
  showMobile(){
    Future<String> data=getSortingOrder();
    print('$data');
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Dash Board", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: NavBar(),
      body: ListView(
        padding: EdgeInsets.only(top: screenSize.width / 30),
        children: <Widget>[
          new Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        //Navigator.pop(context);
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Requisition("")));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 0.0, top: 40.0, right: 0.0, bottom: 0.0),
                        width: screenSize.width / 2.2,
                        height: screenSize.height / 4.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/requisition.png",
                              height: 90.0,
                              width: 350.0,
                            ),
                            SizedBox(height: screenSize.height / 40),
                            Text(
                              "Requisition",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    width: screenSize.width / 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Payment("")));
                      },
                      child: Container(
                          margin: const EdgeInsets.only(
                              left: 0.0, top: 40.0, right: 0.0, bottom: 0.0),
                          width: screenSize.width / 2.2,
                          height: screenSize.height / 4.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/payment.png",
                                height: 90.0,
                                width: 350.0,
                              ),
                              SizedBox(height: screenSize.height / 40),
                              Text(
                                "Payment",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              )
                            ],
                          ))),
                ],
              ),
              SizedBox(height: screenSize.width / 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Promotions("")));
                      },
                      child: Container(
                        width: screenSize.width / 2.2,
                        height: screenSize.height / 4.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/promo.png",
                              height: 90.0,
                              width: 350.0,
                            ),
                            SizedBox(height: screenSize.height / 40),
                            Text(
                              "Promotions",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                //fontSize: 14.5,
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: screenSize.width / 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Message("")));
                      },
                      child: Container(
                          width: screenSize.width / 2.2,
                          height: screenSize.height / 4.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/message.png",
                                height: 90.0,
                                width: 350.0,
                              ),
                              SizedBox(height: screenSize.height / 40),
                              Text(
                                "Message",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              )
                            ],
                          ))),
                ],
              ),
              SizedBox(height: screenSize.width / 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Report("")));
                      },
                      child: Container(
                        width: screenSize.width / 2.2,
                        height: screenSize.height / 4.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/report.png",
                              height: 90.0,
                              width: 350.0,
                            ),
                            SizedBox(height: screenSize.height / 40),
                            Text(
                              "Report",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: screenSize.width / 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Settings("")));
                      },
                      child: Container(
                          width: screenSize.width / 2.2,
                          height: screenSize.height / 4.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/settings.png",
                                height: 90.0,
                                width: 350.0,
                              ),
                              SizedBox(height: screenSize.height / 40),
                              Text(
                                "Settings",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              )
                            ],
                          ))),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
