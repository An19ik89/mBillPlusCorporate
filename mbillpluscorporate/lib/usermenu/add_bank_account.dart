import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_hud/progress_hud.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBankAccount extends StatefulWidget {
  @override
  AddBankAccountPageState createState() => new AddBankAccountPageState();
}

class AddBankAccountPageState extends State<AddBankAccount> {

  String _bankcode,strBankCode="";

  String _branchcode,strBranchCode="";

  //String _orgCode="",strOrganization="";

  String strAccountNumber="",strMobileNumber="",strCustomerNumber="";

  //List<String> orgListCode = new List<String>();
  //List<String> orgListName = new List<String>();

  List<String> bankListCode = new List<String>();
  List<String> bankListName = new List<String>();

  List<String> branchListCode = new List<String>();
  List<String> branchListName = new List<String>();

 // List<DropdownMenuItem<String>> _OrgCode= new List();
  List<DropdownMenuItem<String>> _BankCode= new List();
  List<DropdownMenuItem<String>> _BranchCode = new List();


/*  List<DropdownMenuItem<String>> getOrgName() {

    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < orgListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: orgListName[i], child: new Text(orgListName[i])));
    }
    return items;
  }*/

  List<DropdownMenuItem<String>> getBankName() {

    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < bankListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: bankListName[i], child: new Text(bankListName[i])));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBranchName() {

    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < branchListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: branchListName[i], child: new Text(branchListName[i])));
    }
    return items;
  }

/*  fetchOrgList() async{
    final response = await http.post('http://163.53.150.181/MbillPlusCorporate/DPD_ORGANIZATION_LIST.php');
    List orgRes = json.decode(response.body);
    orgListCode.clear();
    orgListName.clear();
    orgListCode.add("org");
    orgListCode.add("-- Select Organization --");

    for (int i = 0; i < orgRes.length; i++) {
      orgListName.add(orgRes[i]['ORG_NAME']);
      orgListCode.add(orgRes[i]['ORG_CODE']);
    }
    setState(() {
      _OrgCode = getOrgName();
      _orgCode = _OrgCode[0].value;
    });
  }*/

  fetchBankList() async {
    final response = await http.post('http://163.53.150.181/MbillPlusCorporate/DPD_BANK_LIST.php');
    List users = json.decode(response.body);
    //showDialog(context: context, child: progress);
    bankListCode.clear();
    bankListName.clear();
    bankListCode.add("bank");
    bankListName.add("-- Select Bank --");
    //Navigator.of(context).pop();
    for (int i = 0; i < users.length; i++) {
      bankListName.add(users[i]['BANK_NAME']);
      bankListCode.add(users[i]['BANK_CODE']);
    }
    setState(() {
      _BankCode = getBankName();
      _bankcode = _BankCode[0].value;
    });
  }

  fetchBranchList(String _bankcode) async {
    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_BANK_BRANCH_LIST.php',
        body: {
          'P_Bank_Code': _bankcode,
        }
    ).then((response) async {
      List branch = json.decode(response.body);
      branchListCode.clear();
      branchListName.clear();
      branchListCode.add("branch");
      branchListName.add("-- Select Branch --");
      for (int i = 0; i < branch.length; i++) {
        branchListName.add(branch[i]['BRANCH_NAME']);
        branchListCode.add(branch[i]['BANK_BR_CODE']);
      }
      setState(() {
        _BranchCode = getBranchName();
        _branchcode = _BranchCode[0].value;
      });
    });
  }

/*  void changedOrg(String selectedOrg) {
    setState(() {
      _orgCode = selectedOrg;
      //strOrganization = orgListCode[orgListName.indexOf(_orgCode)];
    });
  }*/

  void changedBank(String selectedBank) {
    setState(() {
      _bankcode = selectedBank;
      strBankCode = bankListCode[bankListName.indexOf(_bankcode)];
      print('$strBankCode');
      if (strBankCode != "bank") {
        fetchBranchList(strBankCode);
      } else {
        branchListCode.clear();
        branchListName.clear();
        branchListCode.add("00");
        branchListName.add("-- Select Branch --");
        setState(() {
          _BranchCode = getBranchName();
          _branchcode = _BranchCode[0].value;
        });
      }
    });
  }
  void changedBranch(String selectedBranch) {
    setState(() {
      _branchcode = selectedBranch;
      //strBranchCode = branchListCode[branchListName.indexOf(_branchcode)];
    });
  }

  @override
  void initState() {
    getSortingOrder();
    //fetchOrgList();
    fetchBankList();
    //fetchBranchList();
    branchListCode.add("00");
    branchListName.add("-- Select Branch --");
    setState(() {
      _BranchCode = getBranchName();
      _branchcode = _BranchCode[0].value;
    });
    super.initState();
  }

  String spStrMobileNumber = "",spStrCustomerNumber = "";
  getSortingOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    spStrMobileNumber = prefs.getString("MobileNumber");
    spStrCustomerNumber = prefs.getString("Customer_id");
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("Add Bank", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new Form(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 15.0),

/*                new DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          child: new DropdownButton<String>(
                              value: _orgCode,
                              isDense: true,
                              onChanged:(String newVal){
                                setState(() {
                                  _orgCode = newVal;
                                  changedOrg(_orgCode);
                                });
                              },
                              items: _OrgCode,
                              iconSize: 20.0,
                              style: TextStyle(
                                  inherit: false,
                                  color: Colors.blueAccent,
                                  fontSize: 17.0,
                                  decorationColor: Colors.white)
                          ),
                        ),
                        //new SizedBox(height: 32.0),
                      ],
                    ),
                  ),
                ),*/
                SizedBox(height: 5.0),

                new DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          //isEmpty: _dropdownValue == null,
                          child: new DropdownButton<String>(
                              value: _bankcode,
                              isDense: true,
                              onChanged:(String newVal){
                                setState(() {
                                  _bankcode = newVal;
                                  changedBank(_bankcode);
                                });
                              },
                              items: _BankCode,
                              iconSize: 20.0,
                              style: TextStyle(
                                  inherit: false,
                                  color: Colors.blueAccent,
                                  fontSize: 17.0,
                                  decorationColor: Colors.white)
                          ),
                        ),
                        //new SizedBox(height: 32.0),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 5.0),
                new DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          //isEmpty: _dropdownValue == null,

                          child: new DropdownButton<String>(
                              value: _branchcode,
                              isDense: true,
                              onChanged:(String newVal){
                                setState(() {
                                  _branchcode = newVal;
                                  changedBranch(_branchcode);
                                });
                              } ,
                              items: _BranchCode,
                              iconSize: 20.0,
                              style: TextStyle(
                                  inherit: false,
                                  color: Colors.blueAccent,
                                  fontSize: 17.0,
                                  decorationColor: Colors.white)
                          ),
                        ),
                        //new SizedBox(height: 32.0),
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
                            labelText: "Account Number",
                            labelStyle: TextStyle(
                                fontSize: 18.0, color: Colors.blueAccent),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          // validator: errorAccountNumber,
                          onSaved: (String val) {
                            strAccountNumber = val;
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
                            labelText: "$spStrCustomerNumber",
                            labelStyle:
                            TextStyle(fontSize: 18.0, color: Colors.grey),
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(),
                          ),
                          onSaved: (String val) {
                            strCustomerNumber = val;
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
                            //_validateInputs();
                            _postData();
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

  _postData() async {
    showDialog(context: context, child: progress);
    http.post('http://163.53.150.181/MbillPlusCorporate/Add_Bank.php',
        body: {
          'BankAcc': strAccountNumber,
          'BankCode': strBankCode,
          'Bank_Br_Code': strBranchCode,
          'Amount': "",
          'PaymentMode': "",
          'BankName': "",
          'PayDate': "",
          'Cust_Id': strCustomerNumber,
          'Mobile_No': strMobileNumber,
          'Customer_Bank_Acc_Name': "",
          'Api_Status_Code': "",
          'Api_Status_Desc': "",
          'User_Name': "",
          'TrxnId': "",
        }).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      var statusResult = json.decode(response.body);
      if (statusResult.toString() == '1') {
        print("Success");
        Navigator.pop(context);
      } else {
        print("Failed");
        Navigator.pop(context);
      }
    });
  }
}

var progress = new ProgressHUD(
  backgroundColor: Colors.transparent,
  color: Colors.lightBlue,
  containerColor: Colors.transparent,
  borderRadius: 10.0,
  text: "Sending Information \n\nPlease Wait ....",
);

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}