import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mbillpluscorporate/appbar/navbar.dart';
import 'package:mbillpluscorporate/usermenu/DashBoard.dart';
import 'package:http/http.dart' as http;
import 'package:mbillpluscorporate/usermenu/login_page.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  final String title;
  ChangePassword(this.title);
  @override
  ChangePasswordPageState createState() => new ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePassword> {
  String strMobileNumber="",strOldPassword="",strNewPasswprd="",strRepassword="";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _Retype_Password= new TextEditingController();
  bool _autoValidate = false;
  String spStrMobileNumber="";
  getSortingOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    spStrMobileNumber = prefs.getString("MobileNumber");
  }
  @override
  void initState() {
    // TODO: implement initState
    getSortingOrder();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title:
            new Text("Change Password", style: TextStyle(color: Colors.white)),
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
                SizedBox(height: 5.0),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Old Password",
                            labelStyle: TextStyle(
                                fontSize: 18.0, color: Colors.blueAccent),
                            border: OutlineInputBorder(),
                          ),
                          validator: msgOldPassword,
                          onSaved: (String val) {
                            strOldPassword = val;
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
                          decoration: InputDecoration(
                            labelText: "New Password",
                            labelStyle: TextStyle(
                                fontSize: 18.0, color: Colors.blueAccent),
                            border: OutlineInputBorder(),
                          ),
                          validator: msgNewPassword,onSaved: (String val) {
                          strNewPasswprd = val;
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
                          controller: _Retype_Password,
                          decoration: InputDecoration(
                            labelText: "Re-Type Password",
                            labelStyle: TextStyle(
                                fontSize: 18.0, color: Colors.blueAccent),
                            border: OutlineInputBorder(),
                          ),
                          validator: msgRePassword,
                          onSaved: (String val) {
                          strRepassword = val;
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
                          initialValue: spStrMobileNumber,
                          autofocus: false,
                          focusNode: new AlwaysDisabledFocusNode(),
                          decoration: InputDecoration(
                            labelText: "$spStrMobileNumber",
                            hintText: "$spStrMobileNumber",hintStyle: TextStyle(color: Colors.grey),
                            labelStyle: TextStyle(
                                fontSize: 18.0, color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String val) {
                            strMobileNumber = val;
                          },
                          //validator: errorMobileNumber,
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

  ChangePassworOption() async {
    showDialog(context: context, child: progress);
    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_MBPCO_CUST_PASS_CHANGE.php',body: {
      'P_Cust_Mobile_No': spStrMobileNumber,
      'P_Old_Pass': strOldPassword,
      'P_New_Pass': strNewPasswprd,
    }).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      var statusResult = json.decode(response.body);
      if(statusResult.toString() == '1'){
        print("Success");
        Navigator.of(context).pop();
        _successDialog("Messege","Password Change Successfully");
      }else{
        print("Failed");
        Navigator.pop(context);
        _showDialog("Fail","Password Change Failed");
      }
    });
  }


  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      ChangePassworOption();
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

  String msgNewPassword(String value) {
    if (value.isEmpty)
      return 'Enter Mobile Number';
    else
      return null;
  }

  String msgRePassword(String value) {
    String _Re_pass=_Retype_Password.text;
    if (value.trim() != _Re_pass.trim())
      return 'Password Don\'t Match';
    else if(value.isEmpty){
      return 'Enter Mobile Number';
    }
    return null;
  }



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
                Route route = MaterialPageRoute(builder: (context) => LoginPage("Login"));
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