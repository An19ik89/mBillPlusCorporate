import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mbillpluscorporate/usermenu/DashBoard.dart';
import 'package:mbillpluscorporate/usermenu/mobile_validation.dart';
import 'package:http/http.dart' as http;
import 'package:mbillpluscorporate/usermenu/register_page.dart';
import 'package:mbillpluscorporate/usermenu/settings_page.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final String title;
  LoginPage(this.title);
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String MobileNumber="",Password="";
  String STATUS="",CUST_ID="",CUST_ORG_MAP_STATUS="";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  bool passwordVisible;
  final _userPasswordController = new TextEditingController();
  @override
  void initState() {
    passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("Login", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: Center(
          child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Image.asset(
                          "assets/mbillpluscor.png",
                          height: 100.0,
                          width: 260.0,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "mBill Plus Corporate",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autofocus: false,
                              decoration: InputDecoration(
                                labelText: "Mobile Number",labelStyle: TextStyle(fontSize: 18.0,color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),keyboardType: TextInputType.phone,maxLength: 11,
                              validator: errorMobileNumber,
                              onSaved: (String val) {
                                MobileNumber = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 0.0,bottom: 0.0,right: 8.0),
                            child:TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              controller: _userPasswordController,
                              obscureText: passwordVisible, //This will obscure text dynamically
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',labelStyle: TextStyle(fontSize: 18.0,color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                                // Here is key idea;
                                suffixIcon: IconButton(
                                  icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility,
                                    color:Colors.lightBlue
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      passwordVisible ? passwordVisible = false : passwordVisible = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,5,0,15),
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
                                  "Login",
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

                    SizedBox(height: 5.0),
                    Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                new MobileVarification()));
                          },
                          child: Text(
                            "Don't Have Account? Sing Up Here.",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }

  _logInOption() async {
    showDialog(context: context, child: progress);
    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_MBPCO_CUST_LOGIN.php',body: {
      'P_Cust_Mobile_No': MobileNumber,
      'p_User_Pass': _userPasswordController.text,

    }).then((response) async {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      var statusResult = json.decode(response.body)[0];
      STATUS = statusResult['O_STATUS'];
      CUST_ID = statusResult['CUST_ID'];
      CUST_ORG_MAP_STATUS = statusResult['CUST_ORG_MAP_STATUS'];
      if(STATUS == '1'){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('MobileNumber', MobileNumber);
        prefs.setString('Customer_id', CUST_ID);
        prefs.setString('Map_Status', CUST_ORG_MAP_STATUS);
        if(CUST_ORG_MAP_STATUS== '1') {
          Navigator.of(context).pop();
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) =>
              new DashBoard("Dash Board")));
        }else if(CUST_ORG_MAP_STATUS== '0'){
          Navigator.of(context).pop();
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) =>
              new Settings("Dash Board")));
        }
      }else if(STATUS == '0'){
        print("Failed");
        Navigator.pop(context);
        AlertDilog("Failed","Mobile Number Or Password Don't Match !!");
      }else{
        Navigator.pop(context);
        AlertDilog("Failed","Could Not Connect to Server !!");
      }

    });
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

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _logInOption();
    }
    else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String errorMobileNumber(String value) {
    if (value.isEmpty)
      return 'Enter Mobile Number';
    else
      return null;
  }

  String errorPassWord(String value) {
    if (value.isEmpty)
      return 'Enter Password';
    else
      return null;
  }

}
var progress = new ProgressHUD(
  backgroundColor: Colors.transparent,
  color: Colors.lightBlue,
  containerColor: Colors.transparent,
  borderRadius: 10.0,
  text: "Please Wait ....",
);