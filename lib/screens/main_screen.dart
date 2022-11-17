import 'package:flutter/material.dart';
import 'package:the_latest_tech/screens/setting_screen.dart';

class MainScreen extends StatefulWidget {
  final parseSettingData;

  const MainScreen({Key? key, this.parseSettingData}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String settingName = widget.parseSettingData[0]['name'];
  late String temp = widget.parseSettingData[0]['temp'];
  late String humidity1 = widget.parseSettingData[0]['humidity'];
  late String moisture = widget.parseSettingData[0]['moisture'];
  late String light = widget.parseSettingData[0]['light'];
  late String id = widget.parseSettingData[0]['_id'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Plant',
          style: TextStyle(
            color: Colors.green,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              height: 100,
              decoration: BoxDecoration(),
              child: Container(
                child: Text(
                  'Plant caring',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 90,
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width - 80,
              margin: EdgeInsets.symmetric(horizontal: 40.0),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    )
                  ]),
              child: Column(
                children: [
                  Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 430,
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.green,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SettingScreen(
                            parseSettingData: widget.parseSettingData,
                          );
                        }));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Auto-care settings ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            color: Colors.white,
                            iconSize: 30,
                            icon: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 180,
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 15, left: 10),
                          height: 60,
                          width: MediaQuery.of(context).size.width - 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            settingName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 120,
                          width: MediaQuery.of(context).size.width - 80,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Temperature : $temp',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Humidity : $humidity1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Soiil Moisture : $moisture',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'DayLight : $light',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
