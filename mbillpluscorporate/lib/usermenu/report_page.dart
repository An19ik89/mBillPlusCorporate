import "package:flutter/material.dart";

class Report extends StatefulWidget {
  final String title;
  Report(this.title);
  @override
  ReportState createState() => new ReportState();
}

class ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("Report", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 90.0, top: 20.0, right: 90.0, bottom: 20.0),
                        child: Text("Org Wise Payment",style: TextStyle(color: Colors.lightBlue,fontSize: 16.0),),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 90.0, top: 20.0, right: 90.0, bottom: 20.0),
                        child: Text("Month Wise Payment",style: TextStyle(color: Colors.lightBlue,fontSize: 16.0),),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 90.0, top: 20.0, right: 90.0, bottom: 20.0),
                        child: Text("Date Wise Payment",style: TextStyle(color: Colors.lightBlue,fontSize: 16.0),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
