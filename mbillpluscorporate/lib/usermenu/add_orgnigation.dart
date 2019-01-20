import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbillpluscorporate/usermenu/login_page.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOrganition extends StatefulWidget {
  final String title;
  AddOrganition(this.title);
  @override
  AddOrganitionState createState() => new AddOrganitionState();
}

class AddOrganitionState extends State<AddOrganition> {
  String strMobileNumber = "",
      strOrgList = "",
      strCustomerType = "",
      strCustomerCode = "",
      STATUS_CODE = "",
      DESCRIPTION = "",
      ORGANIZATION_CODE = "",
      CUSTOMER_NAME;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String spStrMobileNumber = "";

  //For DropDown
  List<String> orgListCode = new List<String>();
  List<String> orgListName = new List<String>();
  List<String> customerListCode = new List<String>();
  List<String> customerListName = new List<String>();

  String _orgcode, _customerList;
  List<DropdownMenuItem<String>> _OrgCode;
  List<DropdownMenuItem<String>> _CustomerList;

  List<DropdownMenuItem<String>> getOrgCode() {
    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < orgListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: orgListName[i], child: new Text(orgListName[i])));
    }
    //stateChange = false;
    return items;
  }

  List<DropdownMenuItem<String>> getCustType() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < customerListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: customerListName[i], child: new Text(customerListName[i])));
    }

    return items;
  }

  void changedOrgCode(String selectOrg) {
    setState(() {
      _orgcode = selectOrg;
      String code = orgListCode[orgListName.indexOf(_orgcode)];
      print('$code');
      if (code != "XXX") {
        fetchListUserCustList(_orgcode);
      } else {
        customerListCode.clear();
        customerListName.clear();
        customerListCode.add("00");
        customerListName.add("-- Select Customer Type --");
        setState(() {
          _CustomerList = getCustType();
          _customerList = _CustomerList[0].value;
        });
      }
    });
  }

  void changedCustType(String selectCustype) {
    setState(() {
      _customerList = selectCustype;
    });
  }

  getSortingOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    spStrMobileNumber = prefs.getString("MobileNumber");
  }

  @override
  void initState() {
    // TODO: implement initState
    getSortingOrder();
    fetchListUser();
    customerListCode.add("00");
    customerListName.add("-- Select Customer Type --");
    setState(() {
      _CustomerList = getCustType();
      _customerList = _CustomerList[0].value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title:
        new Text("Add Organigation", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 5.0),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screenSize.width,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.lightBlue,
                            blurRadius: 1.0,
                          ),
                        ]),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                              child: new DropdownButton(
                                value: _orgcode,
                                items: _OrgCode,
                                onChanged: changedOrgCode,
                                iconSize: 20.0,
                                style: TextStyle(
                                    inherit: false,
                                    color: Colors.blueAccent,
                                    fontSize: 17.0,
                                    decorationColor: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screenSize.width,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.lightBlue,
                            blurRadius: 1.0,
                          ),
                        ]),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                              child: new DropdownButton(
                                value: _customerList,
                                items: _CustomerList,
                                onChanged: changedCustType,
                                iconSize: 20.0,
                                style: TextStyle(
                                    inherit: false,
                                    color: Colors.blueAccent,
                                    fontSize: 17.0,
                                    decorationColor: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Dealer / Salesman",
                            labelStyle: TextStyle(
                                fontSize: 18.0, color: Colors.blueAccent),
                            border: OutlineInputBorder(),
                          ),
                          validator: msgOldPassword,
                          onSaved: (String val) {
                            strCustomerCode = val;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autofocus: false,
                          focusNode: new AlwaysDisabledFocusNode(),
                          decoration: InputDecoration(
                            labelText: "$spStrMobileNumber",
                            labelStyle:
                            TextStyle(fontSize: 18.0, color: Colors.grey),
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(),
                          ),
                          onSaved: (String val) {
                            strMobileNumber = val;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.0),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 35),
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          onPressed: () {
                            _validateInputs();
                          },
                          //onPressed: newPage,
                          color: Colors.lightBlue,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: new Text(
                              "Submit",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///All Async task :
  /*---------------------------*/
  CustomerOrgMapOption() async {
    showDialog(context: context, child: progress);
    http.post('http://163.53.150.181/corporate_api/validation.php', body: {
      'orgcode': orgListCode[orgListName.indexOf(_orgcode)],
      'customer_code': strCustomerCode,
      'mobile_number': spStrMobileNumber,
      'type': customerListCode[customerListName.indexOf(_customerList)],
    }).then((response) async {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      var statusResult = json.decode(response.body);
      STATUS_CODE = statusResult['STATUS_CODE'];
      DESCRIPTION = statusResult['DESCRIPTION'];
      ORGANIZATION_CODE = statusResult['ORGANIZATION_CODE'];
      CUSTOMER_NAME = statusResult['CUSTOMER_NAME'];
      print(
          "Status is : $STATUS_CODE, $DESCRIPTION,$ORGANIZATION_CODE,$CUSTOMER_NAME");
      if (STATUS_CODE == '200') {
        print("Success");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('STATUS_CODE', STATUS_CODE);
        prefs.setString('DESCRIPTION', DESCRIPTION);
        prefs.setString('ORGANIZATION_CODE', ORGANIZATION_CODE);
        prefs.setString('CUSTOMER_NAME', CUSTOMER_NAME);
        Navigator.of(context).pop();
        _successDialog(
            "Messege", "Verifiy Successfully\n CUSTOMER_NAME : $CUSTOMER_NAME");
      } else {
        print("Failed");
        Navigator.pop(context);
        _showDialog("Fail", "Verifiy Failed");
      }
    });
  }

  fetchListUser() async {
    final response = await http
        .post('http://163.53.150.181/MbillPlusCorporate/DPD_ORG_MST_LIST.php');
    List users = json.decode(response.body);
    orgListCode.clear();
    orgListName.clear();
    orgListCode.add("XXX");
    orgListName.add("-- Select Org Code --");
    for (int i = 0; i < users.length; i++) {
      orgListName.add(users[i]['ORG_NAME']);
      orgListCode.add(users[i]['ORG_CODE']);
    }
    //if (stateChange) {
    setState(() {
      _OrgCode = getOrgCode();
      _orgcode = _OrgCode[0].value;
    });
    // }
    //return orgList.toList();
  }

  fetchListUserCustList(String _orgcode) async {
    //if (_orgcode != "null") {
    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_CUST_TYPE_LIST.php',
        body: {
          'P_ORG_CODE': _orgcode,
        }).then((response) async {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      List customers = json.decode(response.body);
      customerListCode.clear();
      customerListName.clear();
      customerListCode.add("00");
      customerListName.add("-- Select Customer Type --");
      for (int i = 0; i < customers.length; i++) {
        customerListCode.add(customers[i]['CUST_TYPE_CODE']);
        customerListName.add(customers[i]['CUST_TYPE']);
      }
      //if (stateChange1) {
      setState(() {
        _CustomerList = getCustType();
        _customerList = _CustomerList[0].value;
      });
      //}
      //return customerList.toList();
    });
    //}
  }

  ///Validation :
  /*---------------------------*/
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      CustomerOrgMapOption();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String msgOldPassword(String value) {
    if (value.isEmpty)
      return 'Enter Mobile Number';
    else
      return null;
  }

  ///Aleart Dialog :
  /*---------------------------*/
  void _showDialog(String title, String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg.replaceAll("':','[',']','{','}'", " ")),
          actions: <Widget>[
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _successDialog(String title, String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(msg.replaceAll("':','[',']','{','}'", " ")),
          actions: <Widget>[
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
                Route route =
                MaterialPageRoute(builder: (context) => LoginPage("Login"));
                Navigator.pushReplacement(context, route);
              },
            ),
          ],
        );
      },
    );
  }

}

var progress = new ProgressHUD(
  backgroundColor: Colors.transparent,
  color: Colors.lightBlue,
  containerColor: Colors.transparent,
  borderRadius: 10.0,
  text: "Please Wait ....",
);

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
