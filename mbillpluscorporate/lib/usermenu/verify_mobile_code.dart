import 'package:flutter/material.dart';
import 'package:mbillpluscorporate/usermenu/mobile_validation.dart';
import 'package:mbillpluscorporate/usermenu/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class VerifyMobileCode extends StatefulWidget {
  String mobileNumber = "", verificationId = "";
  VerifyMobileCode(String mobileNumber, String verificationId) {
    this.mobileNumber = mobileNumber;
    this.verificationId = verificationId;
  }
  @override
  VerifyMobileCodeState createState() =>
      new VerifyMobileCodeState(mobileNumber, verificationId);
}

class VerifyMobileCodeState extends State<VerifyMobileCode> {
  String MobileNumber = "", CodeNumber = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String verificationId = "";
  bool _autoValidate = false;
  VerifyMobileCodeState(String MobileNumber, String verificationId) {
    this.MobileNumber = MobileNumber;
    this.verificationId = verificationId;

  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Code"),
      ),
      body: Center(
        child: new Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Enter The Code That Was Send To ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.lightBlue),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$MobileNumber',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18.5,
                            color: Colors.cyan),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, right: 25.0, bottom: 10.0, left: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    autofocus: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        labelText: "Enter Code",
                        labelStyle:
                            TextStyle(color: Colors.lightBlue, fontSize: 18.0),
                        border: OutlineInputBorder()),
                    validator: errorCodeNumber,
                    onSaved: (String val) {
                      CodeNumber = val;
                    },
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 40.0, bottom: 0.0, right: 40.0, top: 0.0),
                  child: Container(
                    child: FloatingActionButton(
                      shape: Border(
                        bottom: BorderSide(color: Colors.red),
                        left: BorderSide(color: Colors.red),
                        right: BorderSide(color: Colors.red),
                        top: BorderSide(color: Colors.red),
                      ),
                      backgroundColor: Colors.lightBlue,
                      child: Text("Continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        _validateInputs();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  checkUser() {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user.phoneNumber == MobileNumber ) {
        SuccessAlertDilog("Welcome", "Your Phone Verification has Complete.");
      } else {
        AlertDilog("Message", "Code You Enter is Invalid.");
      }
    });
  }

  signIn() {
    FirebaseAuth.instance
        .signInWithPhoneNumber(
            verificationId: verificationId, smsCode: CodeNumber)
        .then((user) {
      checkUser();
    }).catchError((e) {
      print(e);
      worngDilog('Error','Some Thing Is Wrong');
    });
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      signIn();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String errorCodeNumber(String value) {
    if (value.isEmpty)
      return 'Please Enter The 6 Digit Code';
    else if (value.length < 6)
      return 'Code Number Must Be 6 Digit';
    else
      return null;
  }

  void AlertDilog(String title, String msg) {
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
              child: new Text("Try Again",style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
                Route route = MaterialPageRoute(
                    builder: (context) => MobileVarification());
                Navigator.pushReplacement(context, route);
              },
            ),
          ],
        );
      },
    );
  }

  void SuccessAlertDilog(String title, String msg) {
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
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                String MobileNumbers= MobileNumber.substring(3,14);
                Route route = MaterialPageRoute(
                    builder: (context) => RegisterPage("Registration", MobileNumbers));
                Navigator.pushReplacement(context, route);
              },
            ),
          ],
        );
      },
    );
  }

  void worngDilog(String title, String msg) {
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
              child: new Text("Try Again",style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
                Route route =
                MaterialPageRoute(builder: (context) => MobileVarification());
                Navigator.pushReplacement(context, route);
              },
            ),
          ],
        );
      },
    );
  }
}
