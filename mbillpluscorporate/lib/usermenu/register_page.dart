import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbillpluscorporate/usermenu/login_page.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:date_format/date_format.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  final String title, mobileNumber;
  RegisterPage(this.title, this.mobileNumber);
  @override
  RegisterPageState createState() => new RegisterPageState(title, mobileNumber);
}

class RegisterPageState extends State<RegisterPage> {
  String title;
  final _Retype_Password= new TextEditingController();
  RegisterPageState(String title, String mobileNumber) {
    this.title = title;
    this.strMobileNumber = mobileNumber;
  }
  Image imageFile;
  String strCustomerNumber = "",
      strCustomerName = "",
      strFatherName = "",
      strMotherName = "",
      strSpouseName = "",
      strGender = "",
      strPhoneNumber = "",
      strMobileNumber = "",
      strNidNumber = "",
      strBirthday = "",
      strEmailAddress = "",
      strPresentAddress = "",
      strPermanentAddress = "",
      strCountryCode = "",
      strDivisionCode = "",
      strDistrictCode = "",
      strThanaCode = "",
      strPostCode = "",
      strPassword = "",
      strRePassword = "",
      strImage = "",base64Image="",location="",_errorCountryCode,_errorDivisionCode,_errorDistrictCode,_errorThanaCode;

  //for Dropdown
  List<String> countryListCode = new List<String>();
  List<String> countryListName = new List<String>();
  List<String> divisionListCode = new List<String>();
  List<String> divisionListName = new List<String>();
  List<String> districtListCode = new List<String>();
  List<String> districtListName = new List<String>();
  List<String> thanaListCode = new List<String>();
  List<String> thanaListName = new List<String>();

  String _countrycode, _divisionList, _districtList, _thanaList;

  List<DropdownMenuItem<String>> _CountryCode;
  List<DropdownMenuItem<String>> _DivisionList;
  List<DropdownMenuItem<String>> _DistrictList;
  List<DropdownMenuItem<String>> _ThanaList;

  List<DropdownMenuItem<String>> getCountryName() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < countryListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: countryListName[i], child: new Text(countryListName[i])));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDivisionName() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < divisionListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: divisionListName[i], child: new Text(divisionListName[i])));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDistrictName() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < districtListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: districtListName[i], child: new Text(districtListName[i])));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getThanaName() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < thanaListName.length; i++) {
      items.add(new DropdownMenuItem(
          value: thanaListName[i], child: new Text(thanaListName[i])));
    }
    return items;
  }

  void changedCountryCode(String selectCountry) {
    setState(() {
      _countrycode = selectCountry;
      strCountryCode = countryListCode[countryListName.indexOf(_countrycode)];
      print('$strCountryCode');
      if (strCountryCode != "-- Select Country --") {
        fetchDivisionList(strCountryCode);
      } else {
        divisionListCode.clear();
        divisionListName.clear();
        divisionListCode.add("00");
        divisionListName.add("-- Select Division --");
        setState(() {
          _DivisionList = getDivisionName();
          _divisionList = _DivisionList[0].value;
        });
      }
    });
  }

  void changedDivision(String selectDivision) {
    setState(() {
      _divisionList = selectDivision;
      strDivisionCode =
      divisionListCode[divisionListName.indexOf(_divisionList)];
      print('$strDivisionCode');
      if (strDivisionCode != "00") {
        fetchDisticList(strDivisionCode);
      } else {
        districtListCode.clear();
        districtListName.clear();
        districtListCode.add("00");
        districtListName.add("-- Select District --");
        setState(() {
          _DistrictList = getDistrictName();
          _districtList = _DistrictList[0].value;
        });
      }
    });
  }

  void changedDistrict(String selectDistrict) {
    setState(() {
      _districtList = selectDistrict;
      strDistrictCode =
      districtListCode[districtListName.indexOf(_districtList)];
      print('$strDistrictCode');
      if (strDistrictCode != "00") {
        fetchThanaList(strDistrictCode);
      } else {
        thanaListCode.clear();
        thanaListName.clear();
        thanaListCode.add("00");
        thanaListName.add("-- Select Thana --");
        setState(() {
          _ThanaList = getDistrictName();
          _thanaList = _ThanaList[0].value;
        });
      }
    });
  }

  void changedThana(String selectThana) {
    setState(() {
      _thanaList = selectThana;
      strThanaCode = thanaListCode[thanaListName.indexOf(_thanaList)];
      print('$strThanaCode');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchCountryList();

    thanaListCode.add("00");
    thanaListName.add("-- Select Thana --");
    setState(() {
      _ThanaList = getThanaName();
      _thanaList = _ThanaList[0].value;
    });

    districtListCode.add("00");
    districtListName.add("-- Select District --");
    setState(() {
      _DistrictList = getDistrictName();
      _districtList = _DistrictList[0].value;
    });

    divisionListCode.add("00");
    divisionListName.add("-- Select Division --");
    setState(() {
      _DivisionList = getDivisionName();
      _divisionList = _DivisionList[0].value;
    });
    super.initState();
  }

  fetchCountryList() async {
    final response = await http
        .post('http://163.53.150.181/MbillPlusCorporate/DPD_COUNTRY_LIST.php');
    List users = json.decode(response.body);
    print("Response body: ${response.body}");
    countryListCode.clear();
    countryListName.clear();
    countryListCode.add("country");
    countryListName.add("-- Select Country --");
    for (int i = 0; i < users.length; i++) {
      countryListName.add(users[i]['COUNTRY_DESC']);
      countryListCode.add(users[i]['COUNTRY_CODE']);
    }
    setState(() {
      _CountryCode = getCountryName();
      _countrycode = _CountryCode[0].value;
    });
  }

  fetchDivisionList(String _countrycode) async {
    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_DIVISION_LIST.php',
        body: {
          'P_Country_Code': _countrycode,
        }).then((response) async {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      List customers = json.decode(response.body);
      divisionListCode.clear();
      divisionListName.clear();
      divisionListCode.add("00");
      divisionListName.add("-- Select Division --");
      for (int i = 0; i < customers.length; i++) {
        divisionListCode.add(customers[i]['DIV_CODE']);
        divisionListName.add(customers[i]['DIV_DESC']);
      }
      //if (stateChange1) {
      setState(() {
        _DivisionList = getDivisionName();
        _divisionList = _DivisionList[0].value;
      });
    });
  }

  fetchDisticList(String divCode) async {
    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_DISTRICT_LIST.php',
        body: {
          'P_Div_Code': divCode,
        }).then((response) async {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      List customers = json.decode(response.body);
      districtListCode.clear();
      districtListName.clear();
      districtListCode.add("00");
      districtListName.add("-- Select District --");
      for (int i = 0; i < customers.length; i++) {
        districtListCode.add(customers[i]['DIST_CODE']);
        districtListName.add(customers[i]['DIST_DESCR']);
      }
      //if (stateChange1) {
      setState(() {
        _DistrictList = getDistrictName();
        _districtList = _DistrictList[0].value;
      });
    });
  }

  fetchThanaList(String ThanaCode) async {
    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_THANA_LIST.php',
        body: {
          'P_Dist_Code': ThanaCode,
        }).then((response) async {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      List customers = json.decode(response.body);
      thanaListCode.clear();
      thanaListName.clear();
      thanaListCode.add("00");
      thanaListName.add("-- Select Thana --");
      for (int i = 0; i < customers.length; i++) {
        thanaListCode.add(customers[i]['THANA_CODE']);
        thanaListName.add(customers[i]['THANA_DESCR']);
      }
      //if (stateChange1) {
      setState(() {
        _ThanaList = getThanaName();
        _thanaList = _ThanaList[0].value;
      });
    });
  }

//For Date Format
  DateTime _date = new DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2200));
    if (picked != null && picked != _date) {
      //print('Date selected: ${convertDateFromString(_date.toString())}');
      setState(() {
        _date = picked;
      });
    }
    strBirthday = convertDateFromString(_date.toString());
  }

  String convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    String date = formatDate(todayDate, [dd, '/', mm, '/', yyyy]);
    return date;
  }

  Future<File> _imageFile;
  VideoPlayerController _controller;
  VoidCallback listener;

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      if (_controller != null) {
        _controller.setVolume(0.0);
        _controller.removeListener(listener);
      }
      _imageFile = ImagePicker.pickImage(source: source);
    });
  }
  Future<String> testComporessList(List<int> list) async
  {
    var result = await FlutterImageCompress.compressWithList(list, quality: 80);
    base64Image = base64Encode(result);
    return base64Image;
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot)
        {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data !=null) {

            imageFile = Image.file(snapshot.data);
            //Image imaging;
            location = snapshot.data.toString();
            List<int> imageBytes = snapshot.data.readAsBytesSync();
            testComporessList(imageBytes);
            //base64Image = base64Encode(imageBytes);
            return imageFile;
          } else if (snapshot.error != null) {
            return const Text(
              'Error picking image.',
              textAlign: TextAlign.center,
            );
          } else {
            return const Center(
                child: Text(
                  'Please Select Your Image',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent,fontSize: 18.0),
                )
            );
          }
        });
  }

//For Validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

//For Gender Select
  int _selectedGender = 0;
  void onChanged(int valueGender) {
    setState(() {
      _selectedGender = valueGender;
    });
    //print("Value $valueGender ");
    if (valueGender.toString() == '1') {
      strGender = 'Male';
      print("Gender Is: $strGender & Value Is $valueGender");
    } else if (valueGender.toString() == '1') {
      strGender = 'Female';
      print("Gender Is: $strGender & Value Is $valueGender");
    }
  }

  @override
  Widget build(BuildContext context) {
    initialValue(val) {
      return TextEditingController(text: val);
    }

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("Registation", style: TextStyle(color: Colors.white)),
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
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autofocus: false,
                              decoration: InputDecoration(
                                labelText: "Customer Number",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.text,
                              validator: errorCustomerNumber,
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
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Customer Name",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.text,
                              validator: errorCustomerName,
                              onSaved: (String val) {
                                strCustomerName = val;
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
                            child: TextField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Father Name",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                setState(() {});
                                strFatherName = value;
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
                            child: TextField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Mother Name",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                setState(() {});
                                strMotherName = value;
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
                            child: TextField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Spouse Name",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                setState(() {});
                                strSpouseName = value;
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
                            Container(
                              width: screenSize.width / 2.5,
                              child: new Text(
                                'Select Gender : ',
                                style:
                                TextStyle(fontSize: 18.0, color: Colors.blueAccent),
                              ),
                            )
                          ],
                        )),
                    Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                    width: screenSize.width / 2.5,
                                    child: new RadioListTile(
                                        title: Text('Male'),
                                        value: 1,
                                        groupValue: _selectedGender,
                                        onChanged: (int Value) {
                                          onChanged(Value);
                                        })),
                                Container(
                                    width: screenSize.width / 2.5,
                                    child: new RadioListTile(
                                        title: Text('Female'),
                                        value: 2,
                                        groupValue: _selectedGender,
                                        onChanged: (int Value) {
                                          onChanged(Value);
                                        })),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(height: 5.0),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.text,
                              validator: errorMobileNumber,
                              onSaved: (String val) {
                                strPhoneNumber = val;
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
                              textInputAction: TextInputAction.next,
                              focusNode: new AlwaysDisabledFocusNode(),
                              decoration: InputDecoration(
                                labelText: "$strMobileNumber",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.text,
                              // validator: errorMobileNumber,
                              onSaved: (String val) {},
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
                            child: TextField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Nid Number",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                setState(() {});
                                strNidNumber = value;
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
                            child: TextField(
                              autofocus: false,
                              controller: initialValue('$strBirthday'),
                              textInputAction: TextInputAction.next,
                              focusNode: new AlwaysDisabledFocusNode(),
                              decoration: InputDecoration(
                                labelText: "Birthday",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                setState(() {});
                                strBirthday = value;
                              },
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      child: Column(
                        children: <Widget>[],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                setState(() {});
                                strEmailAddress = value;
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
                            child: TextField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Present Address",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                setState(() {});
                                strPresentAddress = value;
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
                            child: TextField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Permanent Address",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                setState(() {});
                                strPermanentAddress = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    new DropdownButtonHideUnderline
                      (
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                errorText: _errorCountryCode,
                              ),
                              //isEmpty: _dropdownValue == null,
                              child: new DropdownButton<String>(
                                  value: _countrycode,
                                  isDense: true,
                                  onChanged:(String newVal){
                                    setState(() {
                                      _countrycode = newVal;
                                      if(_countrycode == "-- Select Country --"){
                                        _errorCountryCode="Choose Another";
                                      }
                                      else{
                                        _errorCountryCode=null;
                                        changedCountryCode(_countrycode);
                                      }
                                    });
                                  } ,
                                  items: _CountryCode,
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
                    new DropdownButtonHideUnderline
                      (
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                errorText: _errorDivisionCode,
                              ),
                              //isEmpty: _dropdownValue == null,
                              child: new DropdownButton<String>(
                                  value: _divisionList,
                                  isDense: true,
                                  onChanged:(String newVal){
                                    setState(() {

                                      _divisionList = newVal;
                                      if(_divisionList == "-- Select Division --"){
                                        _errorDivisionCode="Choose Another";
                                      }
                                      else{
                                        _errorDivisionCode=null;
                                        changedDivision(_divisionList);
                                      }

                                    });
                                  },
                                  items: _DivisionList,
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
                    new DropdownButtonHideUnderline
                      (
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                errorText: _errorDistrictCode,
                              ),
                              //isEmpty: _dropdownValue == null,
                              child: new DropdownButton<String>(
                                  value: _districtList,
                                  isDense: true,
                                  onChanged:(String newVal){
                                    setState(() {

                                      _districtList = newVal;
                                      if(_districtList == "-- Select District --"){
                                        _errorDistrictCode="Choose Another";
                                      }
                                      else{
                                        _errorDistrictCode=null;
                                        changedDistrict(_districtList);
                                      }

                                    });
                                  },
                                  items: _DistrictList,
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
/*                    Container(
                      child: Column(
                        children: <Widget>[
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
                                    child: DropdownButtonHideUnderline(
                                      child: new DropdownButton(
                                  value: _districtList,
                                  items: _DistrictList,
                                  onChanged: changedDistrict,
                                  iconSize: 20.0,
                                  style: TextStyle(
                                        inherit: false,
                                        color: Colors.blueAccent,
                                        fontSize: 17.0,
                                        decorationColor: Colors.white),
                                ),
                                    )),
                              ),
                            ],
                          ),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  shape: Border.all(
                                      color: Colors.purple,
                                      width: 10.0,
                                      style: BorderStyle.solid),
                                  child: new DropdownButton(
                                    //hint: new Text("Select Customer Type"),
                                    value: _districtList,
                                    items: _DistrictList,
                                    onChanged: changedDistrict,
                                    iconSize: 20.0,
                                    style: TextStyle(
                                        inherit: false,
                                        color: Colors.blueAccent,
                                        fontSize: 17.0,
                                        decorationColor: Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                    SizedBox(height: 5.0),
                    new DropdownButtonHideUnderline
                      (
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                errorText: _errorThanaCode,
                              ),
                              //isEmpty: _dropdownValue == null,
                              child: new DropdownButton<String>(
                                  value: _thanaList,
                                  isDense: true,
                                  onChanged: (String newVal){
                                    setState(() {

                                      _thanaList = newVal;
                                      if(_thanaList == "-- Select Thana --"){
                                        _errorThanaCode="Choose Another";
                                      }
                                      else{
                                        _errorThanaCode=null;
                                        changedThana(_thanaList);
                                      }

                                    });
                                  },
                                  items: _ThanaList,
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
/*                    Container(
                      child: Column(
                        children: <Widget>[
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
                                    child: DropdownButtonHideUnderline(
                                      child: new DropdownButton(
                                  value: _thanaList,
                                  items: _ThanaList,
                                  onChanged: changedThana,
                                  iconSize: 20.0,
                                  style: TextStyle(
                                        inherit: false,
                                        color: Colors.blueAccent,
                                        fontSize: 17.0,
                                        decorationColor: Colors.white),
                                ),
                                    )),
                              ),
                            ],
                          ),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  shape: Border.all(
                                      color: Colors.purple,
                                      width: 10.0,
                                      style: BorderStyle.solid),
                                  child: new DropdownButton(
                                    //hint: new Text("Select Customer Type"),
                                    value: _thanaList,
                                    items: _ThanaList,
                                    onChanged: changedThana,
                                    iconSize: 20.0,
                                    style: TextStyle(
                                        inherit: false,
                                        color: Colors.blueAccent,
                                        fontSize: 17.0,
                                        decorationColor: Colors.white),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                    SizedBox(height: 5.0),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Post Code",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                setState(() {});
                                strPostCode = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: screenSize.width,
                      height: screenSize.height/4.5,
                      margin: EdgeInsets.only(left: 8.0,right: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: Colors.black45,
                              width: 1.0
                          )
                      ),
                      child: new Row(
                        children: <Widget>[
                          new ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: new Container(
                              width: screenSize.width/2.5,
                              height: screenSize.height/4.5,
                              color: Colors.transparent,
                              child: _previewImage(),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height/8,
                          ),
                          new Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            width: screenSize.width / 2.5,
                            height: screenSize.height/13.5,
                            child: new RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
                              onPressed: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context)
                                  {
                                    // return object of type AlertDialog

                                    return AlertDialog(
                                      title: new Text("Choose One"),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: new Text("Gallery"),
                                          onPressed: () {
                                            _onImageButtonPressed(ImageSource.gallery);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new FlatButton(
                                          child: new Text("Camera"),
                                          onPressed: () {
                                            _onImageButtonPressed(ImageSource.camera);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new FlatButton(
                                          child: new Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              textColor: Colors.white,
                              color: Colors.blue,
                              //color: Colors.cyanAccent,
                              padding: const EdgeInsets.all(5.0),
                              child: new Text(
                                "Browse",
                                style: TextStyle(fontSize: 18.0),
                              ),
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
                              obscureText: true,
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(255, 0, 0, 5)),
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.text,
                              validator: errorPassWord,
                              onSaved: (String val) {
                                strPassword = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.0),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              obscureText: true,
                              autofocus: false,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(255, 0, 0, 5)),
                                labelText: "Re-Type Password",
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                                border: OutlineInputBorder(),
                              ),
                              controller: _Retype_Password,
                              keyboardType: TextInputType.text,
                              validator: errorRePassWord,
                              onSaved: (String val) {
                                strRePassword = val;
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
                                setState(() {
                                  if(_countrycode == "-- Select Country --"){
                                    _errorCountryCode="Choose Another";
                                  }
                                  else if(_divisionList == "-- Select Division --"){
                                    _errorDivisionCode="Choose Another";
                                  } else if(_districtList == "-- Select District --"){
                                    _errorDistrictCode="Choose Another";
                                  }else if(_thanaList == "-- Select Thana --"){
                                    _errorThanaCode="Choose Another";
                                  }
                                  else{
                                    _validateInputs();
                                  }
                                });
                              },
                              //onPressed: newPage,
                              color: Colors.lightBlue,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: new Text(
                                  "Registation",
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
          )),
    );
  }

  _postData() async {
    showDialog(context: context, child: progress);
    http.post('http://163.53.150.181/MbillPlusCorporate/DPD_MBPCO_CUST_REG.php',
        body: {
          'P_Cust_Number': strCustomerNumber,
          'P_Cust_Name': strCustomerName,
          'P_Father_Name': strFatherName,
          'P_Mother_Name': strMotherName,
          'P_Spouse_Name': strSpouseName,
          'P_Gender': strGender,
          'P_Mobile_No': strMobileNumber,
          'P_Password': strPassword,
          'P_Phone': strPhoneNumber,
          'P_Nid': strNidNumber,
          'P_Birth_Date': strBirthday,
          'P_Email_Addr': strEmailAddress,
          'P_Cust_Image': base64Image,
          'P_Pre_Addr': strPresentAddress,
          'P_Per_Addr': strPermanentAddress,
          'P_Country_Code': strCountryCode,
          'P_Div_Code': strDivisionCode,
          'P_Dist_Code': strDivisionCode,
          'P_Thana_Code': strThanaCode,
          'P_Post_Code': strPostCode
        }).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      var statusResult = json.decode(response.body);
      if (statusResult.toString() == '1') {
        print("Success");
        Navigator.pop(context);
        AlertDilog("Messege", "Registation  Successfully.");
      } else {
        print("Failed");
        Navigator.pop(context);
        AlertDilog("Messege", "Registation Failed Successfully.");
      }
    });
  }

  //
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
              onPressed: () {
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

  //Check TextFormField Validation
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _postData();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  ///TextFormField Validation
  String errorCustomerNumber(String value) {
    if (value.isEmpty)
      return 'Enter Customer Number';
    else
      return null;
  }

  String errorCustomerName(String value) {
    if (value.isEmpty)
      return 'Enter Customer Name';
    else
      return null;
  }

  String errorMobileNumber(String value) {
    if (value.isEmpty)
      return 'Enter Mobile Number';
    else
      return null;
  }

  String errorPassWord(String value) {
    String _Re_pass=_Retype_Password.text;
    if (value.isEmpty)
      return 'Enter Password';
    else if(value.trim() != _Re_pass.trim() && value.trim().isNotEmpty && _Re_pass.trim().isNotEmpty)
      return 'Password Doesn\'t Match';
    else
      return null;
  }

  String errorRePassWord(String value) {
    if (value.isEmpty)
      return 'Enter Re-Type Password';
    else
      return null;
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
