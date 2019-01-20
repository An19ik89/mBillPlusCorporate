import 'package:flutter/material.dart';
import 'package:mbillpluscorporate/usermenu/verify_mobile_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class MobileVarification extends StatefulWidget {
  @override
  MobileVarificationState createState() => new MobileVarificationState();
}

class MobileVarificationState extends State<MobileVarification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String MobileNumber = "",finalMobileNumber='';


  String smsCode;
  String verificationId;

  Future<void> verifyPhone() async {

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId,[int forceCodeResend]){
      this.verificationId = verId;
      Route route = MaterialPageRoute(
          builder: (context) => VerifyMobileCode(MobileNumber,verificationId));
      Navigator.pushReplacement(context, route);
      /*smsCodeDialog(context).then((value) {
        print('Signed in');
      });*/
    };
    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user){
      print('verified');
    };
    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.MobileNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve
    );
  }

  /*  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }*/

  /*signIn() {
    FirebaseAuth.instance
        .signInWithPhoneNumber(verificationId: verificationId, smsCode: smsCode)
        .then((user) {
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }*/


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Verification"),
      ),
      body: Center(
        child: new Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Enter Your Mobile Number Here",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.lightBlue),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: "Mobile Number",
                      labelStyle:
                          TextStyle(color: Colors.lightBlue, fontSize: 18.0),
                      border: OutlineInputBorder()),
                  validator: errorMobileNumber,
                  maxLength: 11,
                  onSaved: (String val) {
                    MobileNumber='+88';
                    MobileNumber=MobileNumber+val;
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    child: FloatingActionButton(
                      shape: Border(
                        bottom: BorderSide(color: Colors.red),
                        left: BorderSide(color: Colors.red),
                        right: BorderSide(color: Colors.red),
                        top: BorderSide(color: Colors.red),
                      ),
                      backgroundColor: Colors.lightBlue,
                      child: Text("Next",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        _validateInputs();
                        verifyPhone();
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

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String errorMobileNumber(String value) {
    if (value.isEmpty)
      return 'Please Enter Your Mobile Number';
    else if(value.length<11)
      return'Mobile Number Must Be 11 Digit';
    else
      return null;
  }

}
