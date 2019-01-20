import "package:flutter/material.dart";

class Message extends StatefulWidget {
  final String title;
  Message(this.title);
  @override
  MessageState createState() => new MessageState();
}

class MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("Message", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 90.0, top: 20.0, right: 90.0, bottom: 20.0),
                          child: Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.inbox,
                                    size: 30.0,color: Colors.lightBlue,
                                  ),
                                  SizedBox(
                                    width: 60.0,
                                  ),
                                  Text(
                                    "Inbox",
                                    style: TextStyle(
                                        color: Colors.lightBlue, fontSize: 20.0),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 90.0, top: 20.0, right: 90.0, bottom: 20.0),
                          child: Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.markunread_mailbox,
                                    size: 30.0,color: Colors.lightBlue,
                                  ),
                                  SizedBox(
                                    width: 60.0,
                                  ),
                                  Text(
                                    "Outbox",
                                    style: TextStyle(
                                        color: Colors.lightBlue, fontSize: 20.0),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 90.0, top: 20.0, right: 90.0, bottom: 20.0),
                          child: Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.notifications_active,
                                    size: 30.0,color: Colors.lightBlue,
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text(
                                    "Notification",
                                    style: TextStyle(
                                        color: Colors.lightBlue, fontSize: 19.0),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
