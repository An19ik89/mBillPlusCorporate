import "package:flutter/material.dart";

class AdminNavBar extends StatelessWidget {
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
                      "assets/nulogo.png",
                      height: 100.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "NU Phone Directory",
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
            color: Colors.red,
          ),
          new ListTile(
              leading: Icon(Icons.home),
              title: new Text("Home"),
              /*onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new AdminHome("Home")));
              }*/
              ),
          new ListTile(
            leading: Icon(Icons.search),
            title: new Text("Common Search"),
            /*onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new AdminCommonSearch("Admin Common Search")));
            },*/
          ),
          new ListTile(
            leading: Icon(Icons.account_box),
            title: new Text("About Us"),
            /*onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new AdminAboutUs("About Us")));
            },*/
          ),
          new ListTile(
            leading: Icon(Icons.feedback),
            title: new Text("Feedback"),
            /*onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new AdminFeedBack("Feedback")));
            },*/
          ),
          new ListTile(
            leading: Icon(
              Icons.call,
            ),
            title: new Text("Contact Us"),
            /*onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new AdminContactUs("Contact Us")));
            },*/
          ),
          new Divider(
            height: 15.5,
            color: Colors.grey,
          ),
          new ListTile(
            leading: Icon(Icons.cached),
            title: new Text("Change Password"),
            /*onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new AdminChangePassword("Admin Change Password")));
            },*/
          ),
          new ListTile(
            leading: Icon(Icons.low_priority),
            title: new Text("Admin Logout"),
            /*onTap: () {
              Navigator.of(context).pop();
              Route route = MaterialPageRoute(builder: (context) => AdminLogin(""));
              Navigator.pushReplacement(context, route);


            },*/
          ),
        ],
      ),
    );
  }
}


