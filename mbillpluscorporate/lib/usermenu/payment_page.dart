import "package:flutter/material.dart";

class Payment extends StatefulWidget {
  final String title;
  Payment(this.title);
  @override
  PaymentState createState() => new PaymentState();
}

class PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("Payment", style: TextStyle(color: Colors.white)),
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
                                Icons.launch,
                                size: 30.0,
                              ),
                              SizedBox(
                                width: 80.0,
                              ),
                              Text(
                                "ACI",
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
                                Icons.launch,
                                size: 30.0,
                              ),
                              SizedBox(
                                width: 80.0,
                              ),
                              Text(
                                "IDC",
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
            ],
          )
        ],
      ),
    );
  }
}
