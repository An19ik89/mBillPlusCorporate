import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import 'package:mbillpluscorporate/appbar/navbar.dart';

class Requisition extends StatefulWidget {
  final String title;
  Requisition(this.title);
  @override
  RequisitionState createState() => new RequisitionState(title);
}

class RequisitionState extends State<Requisition> {
  String name = "", id = "";
  bool naviFlag = true;
  final TextEditingController _controller = new TextEditingController();
  bool _IsSearching;
  List<ItemSelectList> data = new List<ItemSelectList>();
  String _searchText = "";

  RequisitionState(String name) {
    this.name = name;

    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar:
      new AppBar(title: Text(name, style: TextStyle(color: Colors.white))),
      drawer: new NavBar(),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: screenSize.width / 1.05,
                      child: Container(
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          controller: _controller,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            contentPadding:
                            EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenSize.height / 1.40,
                child: Center(
                  child: _IsSearching
                      ? FutureBuilder<List<ItemSelectList>>(
                    future: fetchListUser1(data),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ItemSelectList> ItemSelectLists =
                            snapshot.data;
                        return new ListView(
                          children:
                          ItemSelectLists.map((itemSelectList) => Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color:
                                            Colors.black12))),
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: <Widget>[
                                      new Container(
                                        width:
                                        screenSize.width / 1,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  top: 0.0),
                                              child: Row(
                                                children: <
                                                    Widget>[
                                                  Container(
                                                    width: screenSize
                                                        .width /
                                                        1.0,
                                                    child: Column(
                                                      children: <
                                                          Widget>[
                                                        Container(
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(8.0),
                                                            child:
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                new Text(itemSelectList.strItemName, overflow: TextOverflow.ellipsis, style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.lightBlue)),
                                                                new Text(' ( '+itemSelectList.strBrandName+' )', overflow: TextOverflow.ellipsis, style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.lightBlue)),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:8.0,right: 8.0),
                                                          child: Container(
                                                            decoration:
                                                            BoxDecoration(border: Border(bottom: BorderSide(color: Colors.lightBlue, width: 1.0))),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                width: screenSize.width / 2.4,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          Text(
                                                                            "Item Code : ",
                                                                            style: TextStyle(
                                                                                fontSize: 14.0, fontWeight: FontWeight.w700,color: Colors.lightBlue),
                                                                          ),Text(
                                                                            itemSelectList.strItemCode,
                                                                            style: TextStyle(
                                                                                fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: screenSize.width / 2.4,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Row(
                                                                      children: <Widget>[
                                                                        Text(
                                                                          "Brand Code : ",
                                                                          style: TextStyle(
                                                                              fontSize: 14.0, fontWeight: FontWeight.w700,color: Colors.lightBlue),
                                                                        ),Text(
                                                                          itemSelectList.strBrandCode,
                                                                          style: TextStyle(
                                                                              fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                width: screenSize.width / 2.4,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          Text(
                                                                            "Item Code : ",
                                                                            style: TextStyle(
                                                                                fontSize: 14.0, fontWeight: FontWeight.w700,color: Colors.lightBlue),
                                                                          ),Text(
                                                                            itemSelectList.strItemCode,
                                                                            style: TextStyle(
                                                                                fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: screenSize.width / 3.0,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Row(
                                                                      children: <Widget>[
                                                                        /*TextFormField(
                                                                                        textAlign: TextAlign.start,
                                                                                        autofocus: false,
                                                                                        decoration: InputDecoration(
                                                                                          hintText: 'Search',
                                                                                          border: OutlineInputBorder(),
                                                                                        ),
                                                                                      ),*/
                                                                        Text(
                                                                          "Item Code : ",
                                                                          style: TextStyle(
                                                                              fontSize: 14.0, fontWeight: FontWeight.w700,color: Colors.lightBlue),
                                                                        ),Text(
                                                                          itemSelectList.strItemCode,
                                                                          style: TextStyle(
                                                                              fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
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
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return new CircularProgressIndicator();
                    },
                  )
                      : FutureBuilder<List<ItemSelectList>>(
                    future: fetchListUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ItemSelectList> ItemSelectLists =
                            snapshot.data;
                        return new ListView(
                          children:
                          ItemSelectLists.map((itemSelectList) => Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color:
                                            Colors.black12))),
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: <Widget>[
                                      new Container(
                                        width:
                                        screenSize.width / 1,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  top: 0.0),
                                              child: Row(
                                                children: <
                                                    Widget>[
                                                  Container(
                                                    width: screenSize
                                                        .width /
                                                        1.0,
                                                    child: Column(
                                                      children: <
                                                          Widget>[
                                                        Container(
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(8.0),
                                                            child:
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                new Text(itemSelectList.strItemName, overflow: TextOverflow.ellipsis, style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.lightBlue)),
                                                                new Text(' ( '+itemSelectList.strBrandName+' )', overflow: TextOverflow.ellipsis, style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.lightBlue)),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:8.0,right: 8.0),
                                                          child: Container(
                                                            decoration:
                                                            BoxDecoration(border: Border(bottom: BorderSide(color: Colors.lightBlue, width: 1.0))),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Container(
                                                                width: screenSize.width / 2.4,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          Text(
                                                                            "Item Code : ",
                                                                            style: TextStyle(
                                                                                fontSize: 14.0, fontWeight: FontWeight.w700,color: Colors.lightBlue),
                                                                          ),Text(
                                                                            itemSelectList.strItemCode,
                                                                            style: TextStyle(
                                                                                fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: screenSize.width / 2.4,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Row(
                                                                      children: <Widget>[
                                                                        Text(
                                                                          "Brand Code : ",
                                                                          style: TextStyle(
                                                                              fontSize: 14.0, fontWeight: FontWeight.w700,color: Colors.lightBlue),
                                                                        ),Text(
                                                                          itemSelectList.strBrandCode,
                                                                          style: TextStyle(
                                                                              fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Container(
                                                                width: screenSize.width / 2.4,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          Text(
                                                                            "Item Code : ",
                                                                            style: TextStyle(
                                                                                fontSize: 14.0, fontWeight: FontWeight.w700,color: Colors.lightBlue),
                                                                          ),Text(
                                                                            itemSelectList.strItemCode,
                                                                            style: TextStyle(
                                                                                fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: screenSize.width / 2.4,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Row(
                                                                      children: <Widget>[
                                                                        /*TextFormField(
                                                                          textAlign: TextAlign.start,
                                                                          autofocus: false,
                                                                          decoration: InputDecoration(
                                                                            hintText: 'Search',
                                                                            border: OutlineInputBorder(),
                                                                          ),
                                                                        ),*/
                                                                        Text(
                                                                                "Item Code : ",
                                                                                style: TextStyle(
                                                                                    fontSize: 14.0, fontWeight: FontWeight.w700,color: Colors.lightBlue),
                                                                              ),Text(
                                                                                itemSelectList.strItemCode,
                                                                                style: TextStyle(
                                                                                    fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                              ),
                                                                      ],
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
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return new CircularProgressIndicator();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[Text("Total Amount : "), Text("50")],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<ItemSelectList>> fetchListUser1(List<ItemSelectList> data) async {
    List<ItemSelectList> _searchList = List();
    for (int i = 0; i < data.length; i++) {
      String name = data[i].strItemName;
      String id = data[i].strBrandCode;
      if (name.toLowerCase().contains(_searchText.toLowerCase()) ||
          id.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchList.add(data[i]);
      }
    }
    return _searchList;
  }

  Future<List<ItemSelectList>> fetchListUser() async {
    if (data.length < 1) {
      http.post(
          'http://163.53.150.181/corporate_api/item_selection.php', body: {
        'orgcode': 'ACI',
      }).then((response) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
        var statusResult = json.decode(response.body);
        String statusResult2 = statusResult['StatusCode'];
        if (statusResult2 == "200") {
          data.clear();
          List statusResult3 = statusResult['Items'];
          for (int i = 0; i < statusResult3.length; i++) {
            data.add(new ItemSelectList(
              strBrandCode: statusResult3[i]["BrandCode"],
              strRate: statusResult3[i]["Rate"],
              strItemName: statusResult3[i]["ItemName"],
              strBrandName: statusResult3[i]["BrandName"],
              strItemCode: statusResult3[i]["ItemCode"],
            ));
          }
          print("Response body: $data");
        }

      });
      return data.toList();
    }
    return data.toList();
  }

}

class ItemSelectList {
  final String strBrandCode, strItemName, strBrandName, strItemCode;
  double strRate;

  ItemSelectList(
      {this.strBrandCode,
        this.strRate,
        this.strItemName,
        this.strBrandName,
        this.strItemCode});

/* factory ItemSelectList.fromJson(Map<String, dynamic> json) {
    return ItemSelectList(
      strBrandCode: json['BrandCode'] ?? "",
      strRate: json['Rate'] ?? "",
      strItemName: json['ItemName'] ?? "",
      strBrandName: json['BrandName'] ?? "",
      strItemCode: json['ItemCode'] ?? "",
    );
  }*/
}
