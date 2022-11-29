import 'package:flutter/material.dart';
import '../data/network.dart';

class ModalButton extends StatefulWidget {
  final name;
  final currentSetting;

  const ModalButton({Key? key, this.name, this.currentSetting }) : super(key: key);

  @override
  _ModalButtonState createState() => _ModalButtonState();
}

class _ModalButtonState extends State<ModalButton> {
  var name = '';
  var currentSetting = '';
  String? _selectedValue;
  final List<String> settingNameList = [];
  final List<String> tempSettingNameList = ['setting1', 'setting2', 'setting3'];

  @override
  void initState() {
    fetchData();
  }

  void fetchData() async {
    this.name = widget.name;
    this.currentSetting = widget.currentSetting;

    Network settingListNetwork = Network('http://43.201.136.217/settings');

    var settingListData = await settingListNetwork.getJsonData();

    settingListData.forEach((s) => settingNameList.add(s['name']));

    print(settingNameList);


    Future.delayed(Duration(milliseconds: 100), () {
      // this.settingName = settingData['name'];
      // this.settingList = settingListData;
    });


  }

  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(33)
        ),
        primary: Color.fromRGBO(135, 125, 124, 0.8),
        minimumSize: Size(335,60),
        // alignment: Alignment.center,
      ),
      onPressed: () => openModal(context),
      child: Text(
        name,
        style: TextStyle(
          fontFamily: "IBM",
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void openModal(BuildContext context) {
    _selectedValue = this.currentSetting;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            content: Container(
                child: DropdownButton(
                  hint: Text('setting 선택'),
                  items: tempSettingNameList.map(
                        (item) => DropdownMenuItem(
                        child: Text(item),
                        value: item
                    ),
                  ).toList(),
                  onChanged: (String? value) => setState(() {
                    print('==> ${this._selectedValue}');
                    print('==> selected $value');
                    this._selectedValue = value;
                  }),
                  value: _selectedValue,
                )

            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33)
                      ),
                      primary: Color.fromRGBO(253, 132, 17, 0.8),
                      minimumSize: Size(20,30),
                      // alignment: Alignment.center,
                    ),
                    child: Text("적용"),
                    onPressed: fetchData,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33)
                      ),
                      primary: Color.fromRGBO(135, 125, 124, 0.8),
                      minimumSize: Size(20,30),
                      // alignment: Alignment.center,
                    ),
                    child: Text("닫기"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          );
        });
  }
}