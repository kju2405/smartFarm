import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../components/category_value_with_bar.dart';
import '../data/network.dart';


class PlantInfoScreen extends StatefulWidget {
  @override
  _PlantInfoScreenState createState() => _PlantInfoScreenState();
}

class _PlantInfoScreenState extends State<PlantInfoScreen> {
  // LateInitializationError 때문에 임시 초기화
  late String temp = '';
  late String humidity = '';
  late String soilMoisture = '';
  late String daylight = '';
  late String settingName = '';
  late List settings =[];
  var selected_setting;
  late Map select_setting = {};

  @override
  void initState() {
    fetchData();
    getSettings();
  }

  void getSettings() async {
    final response =
    await http.get(Uri.parse('http://43.201.136.217/settings'));
    if (response.statusCode == 200) {
      setState(() {
        settings = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void fetchData() async {
    Network sensorNetwork = Network('http://43.201.136.217/sensors');
    Network currentSettingNetwork = Network('http://43.201.136.217/get/setting');

    var sensorData = await sensorNetwork.getJsonData();
    var settingData = await currentSettingNetwork.getJsonData();

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {

        select_setting = settingData;

        for(int i=0; i < sensorData.length; i++){
          if(sensorData[i]['name'] == 'temp') this.temp = sensorData[i]['value'].toInt().toString() + '℃' ;
          if(sensorData[i]['name'] == 'humidity') this.humidity = sensorData[i]['value'].toInt().toString() + '%';
          if(sensorData[i]['name'] == 'moisture') this.soilMoisture = sensorData[i]['value'].toString() + '%';
          // TODO: daylight 수준 임의 설정 => 확인 필요
          if(sensorData[i]['name'] == 'light') {
            if(sensorData[i]['value'] > 800){
              this.daylight = 'High';
            } else if(sensorData[i]['value'] > 400) {
              this.daylight = 'Medium';
            } else {
              this.daylight = 'Low';
            }
          }
        }
      });
    });
  }

  setSelectSetting(String id) async {
    var url = 'http://43.201.136.217/select/setting';
    var body = {"_id": id};

    var data = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));

    if (data.statusCode == 200) {
      setState(() {
        select_setting = json.decode(data.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  //
  // Future<void> _launchInWebViewOrVC() async {
  //   final Uri url =
  //   Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.inAppWebView,
  //     webViewConfiguration: const WebViewConfiguration(
  //         headers: <String, String>{'my_header_key': 'my_header_value'}),
  //   )) {
  //     throw 'Could not launch $url';
  //   }
  // }

  void activateDevice(String device) async {
    final response =
    await http.get(Uri.parse('http://43.201.136.217/activate/${device}'));
    print(response.statusCode);
  }

  // pump, led, fan 작동 버튼
  Widget _deviceControlButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33)
            ),
            primary: Color.fromRGBO(253, 132, 17, 0.8),
            minimumSize: Size(100,100),
            // alignment: Alignment.center,
          ),
          child: Column(
            children: <Widget> [
              Icon(Icons.water_drop_outlined, size: 50),
              Text(
                'water',
                style: TextStyle(
                  fontFamily: "IBM",
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onPressed: () async {
            activateDevice('pump');
          },
        ),
        SizedBox(width:10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33)
            ),
            primary: Color.fromRGBO(253, 132, 17, 0.8),
            minimumSize: Size(100,100),
            // alignment: Alignment.center,
          ),
          child: Column(
            children: <Widget> [
              Icon(Icons.wb_sunny_outlined, size: 50),
              Text(
                'light',
                style: TextStyle(
                  fontFamily: "IBM",
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onPressed: () async {
            activateDevice('led');
          },
        ),
        SizedBox(width:10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33)
            ),
            primary: Color.fromRGBO(253, 132, 17, 0.8),
            minimumSize: Size(100,100),
            // alignment: Alignment.center,
          ),
          child: Column(
            children: <Widget> [
              Icon(Icons.wind_power_outlined, size: 50),
              Text(
                'wind',
                style: TextStyle(
                  fontFamily: "IBM",
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onPressed: () async {
            activateDevice('fan');
          },
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 164, 74, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 164, 74, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () => fetchData(),
            iconSize: 30,
          ),
        ],
        shadowColor: Colors.transparent,
      ),
      body: ListView(
        children: <Widget> [
          SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 40),
              Image.asset("assets/images/plant.PNG", height: 310,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget> [
                      SizedBox(width: 19),
                      Container(
                        width: 4,
                        height: 25,
                        color: Color.fromRGBO(253, 132, 17, 0.8),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'My Plant',
                        style: TextStyle(
                          fontFamily: "IBM",
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  CategoryValuesWithBar(22, 2, 25, Color.fromRGBO(135, 125, 124, 0.7), temp, 22, Colors.white, 'Temperature', 11, Colors.white),
                  SizedBox(height: 20),
                  CategoryValuesWithBar(22, 2, 25, Color.fromRGBO(135, 125, 124, 0.7), humidity, 22, Colors.white, 'Humidity', 11, Colors.white),
                  SizedBox(height: 20),
                  CategoryValuesWithBar(22, 2, 25, Color.fromRGBO(135, 125, 124, 0.7), soilMoisture, 22, Colors.white, 'Soil moisture', 11, Colors.white),
                  SizedBox(height: 20),
                  CategoryValuesWithBar(22, 2, 25, Color.fromRGBO(135, 125, 124, 0.7), daylight, 22, Colors.white, 'Daylight', 11, Colors.white),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(0,9)
                      )
                    ]
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    CategoryValuesWithBar(180, 2, 25, Color.fromRGBO(253, 132, 17, 0.8), 'Auto-care Status', 15, Colors.black, "${select_setting!['name']}", 12, Color.fromRGBO(63, 60, 60, 1)),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.055,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selected_setting,
                            items: settings!.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value['name']),
                              );
                            }).toList(),
                            hint: Container(
                              child: Text(
                                "Select Auto-care Settings",
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selected_setting = value;
                              });
                              setSelectSetting(selected_setting['_id']);
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    _deviceControlButton(), // 장치 작동 버튼
                    SizedBox(height: 18),
                    ElevatedButton(
                      child: Text(
                        'Real-time Monitoring',
                        style: TextStyle(
                          fontFamily: "IBM",
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33)
                        ),
                        primary: Color.fromRGBO(135, 125, 124, 0.8),
                        minimumSize: Size(335,60),
                      ),
                      onPressed: () async {   //TODO: 카메라
                        final url = Uri.parse('https://google.com');
                        if (await canLaunchUrl(url)) {
                          launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                    SizedBox(height: 300),
                  ],
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}