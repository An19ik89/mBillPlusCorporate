import 'package:flutter/material.dart';
import 'package:mbillpluscorporate/appbar/navbar.dart';
import 'package:mbillpluscorporate/usermenu/BankMap.dart';
import 'package:mbillpluscorporate/usermenu/add_bank_account.dart';
import 'package:mbillpluscorporate/usermenu/change_password.dart';
import 'package:mbillpluscorporate/usermenu/add_orgnigation.dart';


class Settings extends StatefulWidget {
  final String title;
  Settings(this.title);
  @override
  SettingsState createState() => new SettingsState();
}

class SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Settings", style: TextStyle(color: Colors.white)),
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
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new AddOrganition("")));
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
                              "assets/org.png",
                              height: 90.0,
                              width: 350.0,
                            ),
                            SizedBox(height: screenSize.height / 40),
                            Text(
                              "Add Organigation",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
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
                            builder: (BuildContext context) => new AddBankAccount()));
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
                                "assets/Bank.png",
                                height: 90.0,
                                width: 350.0,
                              ),
                              SizedBox(height: screenSize.height / 40),
                              Text(
                                "Add Bank",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
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
                            builder: (BuildContext context) =>
                            new ChangePassword("")));
                      },
                      child: Container(
                        width: screenSize.width / 2.2,
                        height: screenSize.height / 4.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/Change_Pass.png",
                              height: 90.0,
                              width: 350.0,
                            ),
                            SizedBox(height: screenSize.height / 40),
                            Text(
                              "Change Password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
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
                        /*Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new AddOrganition("")));*/

                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new BankOrganization("Bank")));
                      },
                      child: Container(
                          width: screenSize.width / 2.2,
                          height: screenSize.height / 4.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/Notification.png",
                                height: 90.0,
                                width: 350.0,
                              ),
                              SizedBox(height: screenSize.height / 40),
                              Text(
                                "Org && Bank Maping",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
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
