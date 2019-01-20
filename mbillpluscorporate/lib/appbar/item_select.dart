import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbillpluscorporate/appbar/navbar.dart';
import 'package:progress_hud/progress_hud.dart';

class ItemSelect extends StatefulWidget {
  String name = "", id = "";
  ItemSelect(String name, String id) {
    this.name = name;
    this.id = id;
  }

  @override
  _ItemSelectState createState() => _ItemSelectState(name);
}

class _ItemSelectState extends State<ItemSelect> {
  String title = "";
  bool naviFlag = true;
  TextEditingController _controller = new TextEditingController();
  List<ItemSelectModelList> data = null;

  _ItemSelectState(String title) {
    this.title = title;
  }



  String searchingKeyWord;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        title: Text(title, style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: new NavBar(),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: screenSize.width / 1.05,
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.white,
                                        border: new Border.all(
                                          color: Colors.white,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          TextField(
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0),
                                            controller: _controller,
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              hintText:
                                              'Search By Name, Mobile and Email',
                                              contentPadding: EdgeInsets.fromLTRB(
                                                  25.0, 15.0, 25.0, 15.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0)),
                                            ),
                                            onChanged: (String value) {
                                              setState(() {
                                                searchingKeyWord = value;
                                              });
                                              //message = value;
                                            },
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                width: screenSize.width / 2.5,
                                                child: RaisedButton(
                                                  shape: new RoundedRectangleBorder(
                                                      borderRadius:
                                                      new BorderRadius.circular(
                                                          10.0)),
                                                  onPressed: () {
                                                    newPage();
                                                    //showDialog(context: context, child: progress);
                                                    //_postData();
                                                  },
                                                  //onPressed: newPage,
                                                  color: Colors.lightBlue,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(10.0),
                                                    child: new Text(
                                                      "Search",
                                                      style: new TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 18.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                height: screenSize.height / 1.35,
                child: Center(
                    child: FutureBuilder<List<ItemSelectModelList>>(
                      future: fetchListUser(),
                      builder: (context, snapshot)
                      {
                        if (snapshot.hasData) {
                          List<ItemSelectModelList> ItemSelectModelLists = snapshot.data;
                          return new ListView(
                            children:
                            ItemSelectModelLists.map((itemSelectModelList) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Colors.black12))),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        new Container(
                                          width: screenSize.width / 1,
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    top: 0.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(10.0),
                                                      child: CircleAvatar(
                                                        child: Text(
                                                          itemSelectModelList
                                                              .name
                                                              .substring(
                                                              0, 1),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                              30.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                        backgroundColor:
                                                        Colors
                                                            .lightBlue,
                                                        radius: 30.0,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                      screenSize.width /
                                                          1.4,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  8.0),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                      itemSelectModelList
                                                                          .name,
                                                                      maxLines:
                                                                      10,
                                                                      overflow: TextOverflow
                                                                          .ellipsis,
                                                                      style: new TextStyle(
                                                                          fontSize: 18.0,
                                                                          fontWeight: FontWeight.w600,
                                                                          color: Colors.lightBlue)),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color:
                                                                        Colors.lightBlue,
                                                                        width: 1.0))),
                                                          ),
                                                          Container(
                                                            width: screenSize
                                                                .width /
                                                                1.4,
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  4.0),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(3.0),
                                                                    child:
                                                                    Icon(
                                                                      Icons
                                                                          .call,
                                                                      color:
                                                                      Colors.red,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(3.0),
                                                                    child: Text(
                                                                        itemSelectModelList.mobile),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: screenSize
                                                                .width /
                                                                1.4,
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  4.0),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(3.0),
                                                                    child:
                                                                    Icon(
                                                                      Icons
                                                                          .email,
                                                                      color:
                                                                      Colors.red,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(3.0),
                                                                    child: Text(
                                                                        itemSelectModelList.email),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )).toList(),
                          );
                        }
                        return new Text("");
                      },
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String newUrl = "";
  void newPage() {
    newUrl ="http://mis.digital:3004/CBMBillAPI/Integration/ItemSelection?OrgCode=ACI";
    fetchListUser();
  }
  _postData() async {
    showDialog(context: context, child: progress);

    http.post('http://mis.digital:3004/CBMBillAPI/Integration/ItemSelection?OrgCode=ACI',body: {
      'OrgCode': searchingKeyWord
    }).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      var statusResult = json.decode(response.body);
      String statusResult2= statusResult['msg'];
      if (statusResult['status'] == "FAILED") {
        Navigator.pop(context);
        _showDialog(statusResult['status'], statusResult2);
      } else {
        List users = json.decode(response.body)['content'];
        data = users.map((user) => new ItemSelectModelList.fromJson(user)).toList();
      }
    });
  }

  Future<List<ItemSelectModelList>> fetchListUser() async {
    //showDialog(context: context, child: progress);
    var response = await http.get(Uri.encodeFull(newUrl), headers: {"Accept": "application/json"});
    var statusResult = json.decode(response.body);
    if (statusResult['status'] == "SUCCESS") {
      //Navigator.pop();
      List users = json.decode(response.body)['content'];
      data = users.map((user) => new ItemSelectModelList.fromJson(user)).toList();
    } else if (statusResult['status'] == "FAILED") {
      Navigator.pop(context);
      _showDialog(statusResult['status'], statusResult);
    }
    return data;
  }

  void _showDialog(String title, String msg) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg.replaceAll("':','[',']','{','}'", " ")),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ok"),
              onPressed: (
                  ) {
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }
}

class ItemSelectModelList {
  final String email, name;
  String mobile;

  ItemSelectModelList({this.email, this.mobile, this.name});

  factory ItemSelectModelList.fromJson(Map<String, dynamic> json) {
    return ItemSelectModelList(
      email: json['email'] ?? "",
      mobile: json['mobile'] ?? "",
      name: json['name'] ?? "",
    );
  }
}

var progress = new ProgressHUD(
  backgroundColor: Colors.black54,
  color: Colors.white,
  containerColor: Colors.transparent,
  borderRadius: 10.0,
  text: "Loading\nPlease wait......",
);
