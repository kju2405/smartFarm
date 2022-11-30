import 'package:flutter/material.dart';
import 'package:the_latest_tech/environment.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:the_latest_tech/main.dart' as home;
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditingPage extends StatefulWidget {
  const EditingPage(
      {Key? key,
      required this.environment,
      required this.settingId,
      required this.selectedStatus})
      : super(key: key);

  final Environment environment;
  final String settingId;
  final bool selectedStatus;

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  bool status = false;
  bool selected = false;
  TextEditingController name =
      TextEditingController(); //TextField에서 입력된 값을 가져올때 사용함.
  TextEditingController temperature =
      TextEditingController(); //더이상 사용하지 않을때는 리소스의 낭비를 막기위해서 dispose()메서드를 호출함.
  TextEditingController humidity = TextEditingController();
  TextEditingController soil_moisture = TextEditingController();
  TextEditingController daylight = TextEditingController();

  void initState() {
    super.initState();
    name = new TextEditingController(text: widget.environment.title);
    temperature =
        new TextEditingController(text: widget.environment.temperature);
    humidity = new TextEditingController(text: widget.environment.humadity);
    soil_moisture =
        new TextEditingController(text: widget.environment.soilMoisture);
    daylight = new TextEditingController(text: widget.environment.daylight);
    selected = widget.selectedStatus;
  }

  applySelectedStatus() async {
    var url = 'http://43.201.136.217/select/setting';
    var body = {
      '_id': widget.settingId,
      "selected": selected,
    };
    var data = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.environment.title),
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
                        daylight = TextEditingController()
                          ..text = 'Default daylight';
                      } else {
                        name = TextEditingController()
                          ..text = widget.environment.title;
                        temperature = TextEditingController()
                          ..text = widget.environment.temperature;
                        humidity = TextEditingController()
                          ..text = widget.environment.humadity;
                        soil_moisture = TextEditingController()
                          ..text = widget.environment.soilMoisture;
                        daylight = TextEditingController()
                          ..text = widget.environment.daylight;
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
                      TextField(
                        controller: daylight,
                        decoration: InputDecoration(
                          labelText: 'The daylight that will be keeped',
                          hintText: 'Daylight',
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 50)),
                          Text(
                            'Selected',
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
                            width: 60.0,
                            height: 30.0,
                            valueFontSize: 12.0,
                            toggleSize: 20.0,
                            value: selected,
                            borderRadius: 30.0,
                            padding: 6.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                selected = val;
                              });
                              print('$selected');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (name.text == '' ||
                                  temperature.text == '' ||
                                  humidity.text == '' ||
                                  soil_moisture.text == '' ||
                                  daylight.text == '') {
                                showSnackBar(context);
                              } else {
                                final response = await http.post(
                                  Uri.parse(
                                      'http://43.201.136.217/update/settings'),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(<String, String>{
                                    '_id': widget.settingId,
                                    'name': name.text,
                                    'temp': temperature.text,
                                    'humidity': humidity.text,
                                    'moisture': soil_moisture.text,
                                    'light': daylight.text,
                                  }),
                                );
                                applySelectedStatus();
                                print('Response status:${response.statusCode}');
                                print('Response body:${response.body}');
                                Navigator.pop(context);
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
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showSnackBarDelete(
                                  context,
                                  name,
                                  temperature,
                                  humidity,
                                  soil_moisture,
                                  daylight,
                                  widget.settingId);
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                minimumSize: Size(100.0, 50.0)),
                          ),
                        ],
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

void showSnackBarDelete(
    BuildContext context,
    TextEditingController name,
    TextEditingController temperature,
    TextEditingController humidity,
    TextEditingController soil_moisture,
    TextEditingController daylight,
    String settingId) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '정말로 삭제하시겠습니까?',
      ),
      action: SnackBarAction(
        label: '예',
        onPressed: () async {
          var url = 'http://43.201.136.217/delete/settings';
          var body = {
            "_id": settingId,
          };

          var data = await http.post(Uri.parse(url),
              body: json.encode(body),
              headers: {"Content-Type": "application/json"},
              encoding: Encoding.getByName("utf-8"));
          Navigator.pop(context);
        },
        textColor: Colors.white,
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.blue,
    ),
  );
}
