import 'package:flutter/material.dart';
import '../environment.dart';
import '../environment_page.dart';
import '../data/network.dart';

class SettingScreen extends StatefulWidget {
  final parseSettingData;

  const SettingScreen({Key? key, this.parseSettingData}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late String settingName;
  late String temp;
  late String humidity1;
  late String moisture;
  late String light;
  late String id;
  late bool selectedStatus;

  static List<String> titleList = [];
  static List<String> temperatureList = [];
  static List<String> humadityList = [];
  static List<String> soilMoistureList = [];
  static List<String> daylightList = [];
  static List<String> idList = [];
  static List<bool> selectedList = [];
  List<Environment> environmentData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addToList(widget.parseSettingData);
    updateData(widget.parseSettingData);
    print('init');
  }

  void addToList(dynamic settingData) {
    titleList = [];
    temperatureList = [];
    humadityList = [];
    soilMoistureList = [];
    daylightList = [];
    idList = [];
    selectedList = [];
    // print('settingData.length');
    print(settingData.length.runtimeType);
    print(settingData.length);
    print(settingData[1]['moistrue']);
    final int len = settingData.length;
    for (int i = 0; i < len; i++) {
      var settingDataTitle = settingData[i]['name'];
      var settingDataTemp = settingData[i]['temp'];
      var settingDataHumadity = settingData[i]['humidity'];
      var settingDataMoisture = settingData[i]['moisture'];
      var settingDataDaylight = settingData[i]['light'];
      var settingDataId = settingData[i]['_id'];
      var settingDataSelected = settingData[i]['selected'];

      titleList.add(settingDataTitle);
      temperatureList.add(settingDataTemp);
      humadityList.add(settingDataHumadity);
      soilMoistureList.add(settingDataMoisture);
      daylightList.add(settingDataDaylight);
      idList.add(settingDataId);
      selectedList.add(settingDataSelected);
    }
    // settingData.forEach((s) => titleList.add(s['name']));
    // settingData.forEach((s) => temperatureList.add(s['temp']));
    // settingData.forEach((s) => humadityList.add(s['humidity']));
    // settingData.forEach((s) => soilMoistureList.add(s['moisture']));
    // settingData.forEach((s) => daylightList.add(s['light']));
    // settingData.forEach((s) => idList.add(s['_id']));
    // settingData.forEach((s) => selectedList.add(s['selected']));
  }

  void updateData(dynamic settingData) {
    final settingLength = settingData.length;

    environmentData = [];
    selectedList = [];
    for (int i = 0; i < settingLength; i++) {
      settingName = settingData[i]['name'];
      temp = settingData[i]['temp'];
      humidity1 = settingData[i]['humidity'];
      moisture = settingData[i]['moisture'];
      light = settingData[i]['light'];
      id = settingData[i]['_id'];
      selectedStatus = settingData[i]['selected'];
      environmentData
          .add(Environment(settingName, temp, humidity1, moisture, light));
      selectedList.add(selectedStatus);
    }
    // environmentData = List.generate(
    //     titleList.length,
    //     (index) => Environment(titleList[index], temperatureList[index],
    //         humadityList[index], soilMoistureList[index], daylightList[index]));
    // print(settingName);
    // print(humidity);
  }

  void refresh() async {
    Network network = Network('http://43.201.136.217/settings');
    var settingData = await network.getJsonData();
    if (settingData.length > titleList.length) {
      final lastLength = settingData.length - 1;
      settingName = settingData[lastLength]['name'];
      temp = settingData[lastLength]['temp'];
      humidity1 = settingData[lastLength]['humidity'];
      moisture = settingData[lastLength]['moisture'];
      light = settingData[lastLength]['light'];
      id = settingData[lastLength]['_id'];
      selectedStatus = settingData[lastLength]['selected'];
      titleList.add(settingName);
      temperatureList.add(temp);
      humadityList.add(humidity1);
      soilMoistureList.add(moisture);
      daylightList.add(light);
      idList.add(id);
      selectedList.add(selectedStatus);
    }
    // else if(settingData.length<titleList.length){
    //   for(int i=0;i<)
    // }

    updateData(settingData);
    updateData(settingData);
    print(settingData[0]['_id'].runtimeType);
    print(environmentData.length);
    print(titleList.length);
  }

  TextEditingController name =
      TextEditingController(); //TextField?????? ????????? ?????? ???????????? ?????????.
  TextEditingController temperature =
      TextEditingController(); //????????? ???????????? ???????????? ???????????? ????????? ??????????????? dispose()???????????? ?????????.
  TextEditingController humidity = TextEditingController();
  TextEditingController soil_moisture = TextEditingController();
  TextEditingController daylight = TextEditingController();
  bool status = false;

  @override
  Widget build(BuildContext context) {
    refresh();
    print('build method');
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0.2,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
            onPressed: () async {
              // setState(() {
              //   environmentData = List.generate(
              //       titleList.length,
              //           (index) => Environment(titleList[index], temperatureList[index],
              //           humadityList[index], soilMoistureList[index], daylightList[index]));
              // });
              // Network network = Network('http://43.201.136.217/settings');
              // var settingData = await network.getJsonData();
              // if(settingData.length>titleList.length){
              //   final lastLength=settingData.length-1;
              //   settingName=settingData[lastLength]['name'];
              //   temp=settingData[lastLength]['temp'];
              //   humidity1=settingData[lastLength]['humidity'];
              //   moisture=settingData[lastLength]['moisture'];
              //   light=settingData[lastLength]['light'];
              //   titleList.add(settingName);
              //   temperatureList.add(temp);
              //   humadityList.add(humidity1);
              //   soilMoistureList.add(moisture);
              //   daylightList.add(light);
              // }
              //
              // updateData(settingData);
              // print(environmentData.length);
              // print(titleList.length);
              refresh();
              setState(() {});
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/new');
              },
              icon: Icon(Icons.add_box_rounded))
        ],
      ),
      body: ListView.builder(
        itemCount: environmentData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => EditingPage(
                //       environment: environmentData[index],
                //       settingId: idList[index],
                //     )));
                // debugPrint(titleList[index]);
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                  child: IntrinsicHeight(
                    //????????? ????????? VerticalDivider??? ??????????????????.
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          environmentData[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        const VerticalDivider(
                          width: 5.0,
                          thickness: 2.0,
                          indent: 5.0,
                          endIndent: 5.0,
                          color: Colors.grey,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Temperature ${environmentData[index].temperature}??C',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Humadity ${environmentData[index].humadity}%',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Soil Moisture ${environmentData[index].soilMoisture}%',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'daylight ${environmentData[index].daylight} ',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'selected ${selectedList[index]} ',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditingPage(
                                  environment: environmentData[index],
                                  settingId: idList[index],
                                  selectedStatus: selectedList[index],
                                ),
                              ),
                            );
                            debugPrint(titleList[index]);
                            debugPrint(environmentData[index].temperature);
                            debugPrint(selectedList[index].toString());
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.black87,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
