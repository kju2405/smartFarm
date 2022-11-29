import 'package:flutter/material.dart';
import 'package:the_latest_tech/new.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:the_latest_tech/screens/plant_info_screen.dart';
import 'package:the_latest_tech/screens/setting_screen.dart';
import 'data/network.dart';
import 'screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  //StatefulWidget은 StatefulWidget(immutable), State(mutable)로 이루어져있음.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Farm',
      initialRoute: '/',
      routes: {
        '/': (context) => Settings(),
        '/new': (context) => New(),
        '/plant_info': (context) => PlantInfoScreen(),
      },
    );
  }
}

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    Network network = Network('http://43.201.136.217/settings');
    var settingData = await network.getJsonData();
    Future.delayed(Duration(milliseconds: 3000),() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MainScreen(parseSettingData: settingData,);
        //   SettingScreen(
        //   parseSettingData: settingData,
        // );
      }));
    }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          'My Plant',
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
