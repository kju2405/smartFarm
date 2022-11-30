import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:the_latest_tech/main.dart';
import 'package:http/http.dart' as http;

class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  TextEditingController name =
      TextEditingController(); //TextField에서 입력된 값을 가져올때 사용함.
  TextEditingController temperature =
      TextEditingController(); //더이상 사용하지 않을때는 리소스의 낭비를 막기위해서 dispose()메서드를 호출함.
  TextEditingController humidity = TextEditingController();
  TextEditingController soil_moisture = TextEditingController();
  // TextEditingController daylight = TextEditingController();
  bool status = false;

  String? selected_daylight = "";
  List daylightList = ['Low', 'Medium', 'High'];
  var dayl;

  addSetting() async {
    var url = 'http://43.201.136.217/add/settings';
    var body = {
      "humidity": humidity.text.toString(),
      "light": selected_daylight,
      "moisture": soil_moisture.text.toString(),
      "name": name.text.toString(),
      "selected": false,
      "temp": temperature.text.toString()
    };

    var data = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));

    if (data.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Setting'),
        centerTitle: true,
        elevation: 0.2,
        backgroundColor: Colors.green,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); //이를 통해서 FocusNode를 찾을 수 있고, unfocus()를 통해서 포커스를 해제할 수 있음.
        },
        child: SingleChildScrollView(
          //키보드가 올라올때 키보드에 의해서 화면이 가려지는걸 방지.
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 50)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 45)),
                  Text(
                    'default',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  FlutterSwitch(
                    activeColor: Colors.orangeAccent,
                    width: 80.0,
                    height: 40.0,
                    valueFontSize: 15.0,
                    toggleSize: 25.0,
                    value: status,
                    borderRadius: 30.0,
                    padding: 6.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        status = val;
                      });
                      print('$status');
                      if (status) {
                        name = TextEditingController()..text = 'Default Name';
                        temperature = TextEditingController()
                          ..text = 'Default temperature';
                        humidity = TextEditingController()
                          ..text = 'Default humidity';
                        soil_moisture = TextEditingController()
                          ..text = 'Default moisture';
                        // daylight = TextEditingController()
                        //   ..text = 'Default daylight';
                        dayl = daylightList[0];
                        selected_daylight = dayl;
                      } else {
                        name = TextEditingController()..text = '';
                        temperature = TextEditingController()..text = '';
                        humidity = TextEditingController()..text = '';
                        soil_moisture = TextEditingController()..text = '';
                        // daylight = TextEditingController()..text = '';
                      }
                    },
                  ),
                ],
              ),
              Form(
                  child: Theme(
                data: ThemeData(
                    primaryColor: Colors.teal,
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle:
                            TextStyle(color: Colors.teal, fontSize: 15.0))),
                child: Container(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: name, //controller와 TextField연결.
                        decoration: InputDecoration(
                          labelText: 'Enter the name of the setting',
                          hintText: 'Name',
                        ),
                        keyboardType:
                            TextInputType.emailAddress, //keyboard에 @가 있음.
                        autofocus: true, //자동으로 focus가 맞춰짐.(자동으로 keyboard가 올라옴)
                      ),
                      TextField(
                        controller: temperature,
                        decoration: InputDecoration(
                          labelText: 'The temperature that will be keeped',
                          hintText: 'Temperature',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: humidity,
                        decoration: InputDecoration(
                          labelText: 'The Humidity that will be keeped',
                          hintText: 'Humidity',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: soil_moisture,
                        decoration: InputDecoration(
                          labelText: 'The soil moisture that will be keeped',
                          hintText: 'Soil moisture',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      // TextField(
                      //   controller: daylight,
                      //   decoration: InputDecoration(
                      //     labelText: 'The daylight that will be keeped',
                      //     hintText: 'Daylight',
                      //   ),
                      //   keyboardType: TextInputType.text,
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: dayl,
                              items: daylightList!.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: Container(
                                child: Text(
                                  "The daylight that will be keeped",
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  dayl = value;
                                  selected_daylight = dayl;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (name.text == '' ||
                              temperature.text == '' ||
                              humidity.text == '' ||
                              soil_moisture.text == '' ||
                              selected_daylight == '') {
                            showSnackBar(context);
                          } else {
                            addSetting();
                          }
                        },
                        child: Text(
                          'Apply',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            minimumSize: Size(100.0, 50.0)),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '모든 정보를 입력해주세요.',
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
    ),
  );
}
