import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbillpluscorporate/usermenu/login_page.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankOrganization extends StatefulWidget {
  final String title;
  BankOrganization(this.title);
  @override
  BankOrganizationState createState() => new BankOrganizationState();
}

class BankOrganizationState extends State<BankOrganization> {
  String strMobileNumber = "",
      strOrgList = "",
      strCustomerType = "",
      strCustomerCode = "",
      STATUS_CODE = "",
      DESCRIPTION = "",
      ORGANIZATION_CODE = "",
      CUSTOMER_NAME="";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String spStr_Cust_ID = "",spStrMobileNumber="";

  //For DropDown
  List<String> orgListCode = new List<String>();
  List<String> orgListName = new List<String>();

  List<String> bankListCode = new List<String>();
  List<String> bankListName = new List<String>();

  List<String> branchListCode = new List<String>();
  List<String> branchListName = new List<String>();

  //List<String> accountListCode = new List<String>();
  List<String> accountListName = new List<String>();

  String _orgcode,strOrgCode,_bankcode,strBankCode,_branchCode,strBranchCode,_accountCode,strAccountCode;

  List<DropdownMenuItem<String>> _OrgCode;
  List<DropdownMenuItem<String>> _BankCode;
  List<DropdownMenuItem<String>> _BranchCode;
  List<DropdownMenuItem<String>> _BankAccountCode;

  List<DropdownMenuItem<String>> getOrgCode() {
    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < orgListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: orgListName[i], child: new Text(orgListName[i])));
    }
    //stateChange = false;
    return items;
  }

  List<DropdownMenuItem<String>> getBankCode() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < bankListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: bankListName[i], child: new Text(bankListName[i])));
    }

    return items;
  }


  List<DropdownMenuItem<String>> getBranchCode() {
    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < branchListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: branchListName[i], child: new Text(branchListName[i])));
    }
    return items;
  }


  List<DropdownMenuItem<String>> getAccountCode() {
    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < accountListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: accountListName[i], child: new Text(accountListName[i])));
    }
    return items;
  }

  void changedOrgCode(String selectOrg) {
    setState(() {
      _orgcode = selectOrg;
      strOrgCode = orgListCode[orgListName.indexOf(_orgcode)];
      //print('$strOrgCode');
      if (strOrgCode != "00") {
        fetchBankData();
      } else {
        bankListCode.clear();
        bankListName.clear();
        bankListCode.add("00");
        bankListName.add("-- Select Bank --");

        branchListName.clear();
        branchListCode.clear();
        branchListCode.add("00");
        branchListName.add("-- Select Branch --");

        accountListName.clear();
        accountListName.add("-- Select Account --");

        setState(() {
          _BankCode = getBankCode();
          _bankcode = _BankCode[0].value;

          _BranchCode = getBranchCode();
          _branchCode = _BranchCode[0].value;

          _BankAccountCode = getAccountCode();
          _accountCode = _BankAccountCode[0].value;
        });
      }
    });
  }

  void changedBank(String selectedBank) {
    setState(() {
      _bankcode = selectedBank;
      strBankCode = bankListCode[bankListName.indexOf(_bankcode)];

      if (strBankCode != "00") {
        fetchBranchData(strBankCode);
      } else {
        branchListCode.clear();
        branchListName.clear();
        branchListCode.add("00");
        branchListName.add("-- Select Branch--");

        accountListName.clear();
        accountListName.add("-- Select Account --");
        setState(() {
          _BranchCode = getBranchCode();
          _branchCode = _BranchCode[0].value;
          _BankAccountCode = getAccountCode();
          _accountCode=_BankAccountCode[0].value;
        });
      }
    });
  }

  void changedBranch(String selectedBranch) {
    setState(() {
      _branchCode = selectedBranch;
      strBranchCode = branchListCode[branchListName.indexOf(_branchCode)];

      if (strBranchCode != "00") {
        fetchBankAccountData(strBranchCode);
      } else {
        accountListName.clear();
        accountListName.add("-- Select Account --");
        setState(() {
          _BankAccountCode = getAccountCode();
          _accountCode = _BankAccountCode[0].value;
        });
      }

    });
  }


  void changedAccount(String selectedAccount) {
    setState(() {
      _accountCode = selectedAccount;
      //strAccountCode = accountListCode[accountListName.indexOf(_accountCode)];
    });
  }

  getSortingOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    spStr_Cust_ID = prefs.getString("Customer_id");
    spStrMobileNumber = prefs.getString("MobileNumber");
    fetchORgList();
  }

  @override
  void initState() {
    getSortingOrder();
    //fetchORgList();
    bankListCode.add("00");
    bankListName.add("-- Select Bank --");

    branchListCode.add("00");
    branchListName.add("-- Select Branch --");

    //accountListCode.add("00");
    accountListName.add("-- Select Account --");

    setState(() {
      _BankCode = getBankCode();
      _bankcode = _BankCode[0].value;

      _BranchCode = getBranchCode();
      _branchCode = _BranchCode[0].value;

      _BankAccountCode = getAccountCode();
      _accountCode = _BankAccountCode[0].value;
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
        new Text("Bank and Organigation", style: TextStyle(color: Colors.white)),
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
                              value: _orgcode,
                              isDense: true,
                              onChanged:(String newVal){
                                setState(() {
                                  _orgcode = newVal;
                                  changedOrgCode(_orgcode);
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
                              value: _branchCode,
                              isDense: true,
                              onChanged:(String newVal){
                                setState(() {
                                  _branchCode = newVal;
                                  changedBranch(_branchCode);
                                });
                              },
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
                              value: _accountCode,
                              isDense: true,
                              onChanged:(String newVal){
                                setState(() {
                                  _accountCode = newVal;
                                  changedAccount(_accountCode);
                                });
                              },
                              items: _BankAccountCode,
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
                          focusNode: new AlwaysDisabledFocusNode(),
                          decoration: InputDecoration(
                            labelText: "$spStr_Cust_ID",
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
    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_CUSTOMER_ORG_BANK_ACC_MAP.php', body: {
      'P_Mbp_Org_Code': strOrgCode,
      'P_Bank_Code': strBankCode,
      'P_Bank_Br_Code': strBranchCode,
      'P_Bank_Acc': _accountCode,
      'P_Cust_Id': spStr_Cust_ID,
      'P_Mobile_No': spStrMobileNumber,
      'P_USER_NAME': spStrMobileNumber,
    }).then((response) async {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      var statusResult = json.decode(response.body);
      if(statusResult.toString() == '1'){
        print("Success");
        Navigator.of(context).pop();
        _successDialog("Messege","Maping Complete Successfully");
      }else{
        print("Failed");
        Navigator.pop(context);
        _showDialog("Fail","Maping Failed");
      }
    });
  }

  //For Organization
  fetchORgList() async {
    final response = await http
        .post('http://163.53.150.181/MbillPlusCorporate/DPD_ORGANIZATION_LIST.php',
        body: {
         'P_Cust_Id':spStr_Cust_ID
    });
    List users = json.decode(response.body);
    orgListCode.clear();
    orgListName.clear();
    orgListCode.add("00");
    orgListName.add("-- Select Org Code --");
    for (int i = 0; i < users.length; i++) {
      orgListName.add(users[i]['ORG_NAME']);
      orgListCode.add(users[i]['ORG_CODE']);
    }
    setState(() {
      _OrgCode = getOrgCode();
      _orgcode = _OrgCode[0].value;
    });

  }

  //For Bank
  fetchBankData() async {
    final response = await http
        .post('http://163.53.150.181/MbillPlusCorporate/DPD_BANK_LIST_MAP.php',
        body: {'P_Cust_Id':"1"});
    List users = json.decode(response.body);
    bankListCode.clear();
    bankListName.clear();
    bankListCode.add("00");
    bankListName.add("-- Select Bank --");
    for (int i = 0; i < users.length; i++) {
      bankListName.add(users[i]['BANK_NAME']);
      bankListCode.add(users[i]['BANK_CODE']);
    }
    setState(() {
      _BankCode = getBankCode();
      _bankcode = _BankCode[0].value;
    });

  }


  //For Bank Branch
  fetchBranchData(String recieveBranchCode) async {

    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_BANK_BRANCH_LIST_MAP.php',
        body: {
          'P_Bank_Code': recieveBranchCode,
          'P_Cust_Id':"1"
        }).then((response) async {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      List branches = json.decode(response.body);
      branchListName.clear();
      branchListCode.clear();
      branchListCode.add("00");
      branchListName.add("-- Select Branch --");
      for (int i = 0; i < branches.length; i++) {
        branchListCode.add(branches[i]['BANK_BR_CODE']);
        branchListName.add(branches[i]['BRANCH_NAME']);
      }
      setState(() {
        _BranchCode = getBranchCode();
        _branchCode = _BranchCode[0].value;
      });
    });

  }


  //For Bank Branch
  fetchBankAccountData(String recieveBranchCode) async {

    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_BANK_ACCOUNT_LIST.php',
        body: {
          'P_Bank_Code': strBankCode,
          'P_Bank_Br_Code': recieveBranchCode,
          'P_Cust_Id':"1"
        }).then((response) async {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      List accounts = json.decode(response.body);
      accountListName.clear();
      accountListName.add("-- Select Account --");
      for (int i = 0; i < accounts.length; i++) {
        accountListName.add(accounts[i]['BANK_ACC']);
      }
      setState(() {
        _BankAccountCode = getAccountCode();
        _accountCode = _BankAccountCode[0].value;
      });
    });

  }

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
