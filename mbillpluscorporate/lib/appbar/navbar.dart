import "package:flutter/material.dart";
import 'package:mbillpluscorporate/usermenu/DashBoard.dart';
import 'package:mbillpluscorporate/usermenu/add_bank_account.dart';
import 'package:mbillpluscorporate/usermenu/change_password.dart';
import 'package:mbillpluscorporate/usermenu/add_orgnigation.dart';
import 'package:mbillpluscorporate/usermenu/login_page.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/mbillpluscor.png",
                      height: 80.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "mBill Plus Corporate",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Divider(
            height: 15.5,
            color: Colors.blue,
          ),
          new ListTile(
            leading: Icon(Icons.home,color: Colors.blue,),
            title: new Text("Home"),
            onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new DashBoard("Home")));
              }
          ),
          new ListTile(
            leading: Icon(Icons.account_circle,color: Colors.blue,),
            title: new Text("Profile"),
            /*onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Home("Profile")));
              }*/
          ),
          new ListTile(
            leading: Icon(Icons.add_circle_outline,color: Colors.blue,),
            title: new Text("Add Account"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new AddOrganition("Add Account")));
            },
          ),
          new Divider(
            height: 15.5,
            color: Colors.grey,
          ),
          new ListTile(
            leading: Icon(Icons.cached,color: Colors.blue,),
            title: new Text("Change Password"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new ChangePassword("Change Password")));
            },
          ),
          new Divider(
            height: 15.5,
            color: Colors.grey,
          ),
          new ListTile(
            leading: Icon(Icons.low_priority,color: Colors.blue,),
            title: new Text("Logout"),
            onTap: () {
              Navigator.of(context).pop();
              Route route = MaterialPageRoute(builder: (context) => LoginPage("Login"));
              Navigator.pushReplacement(context, route);
            },
          ),
        ],
      ),
    );
  }
}
