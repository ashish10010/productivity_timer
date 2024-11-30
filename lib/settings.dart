import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static const String WORKTIME = 'workTime';
  static const String SHORTBREAK = 'shortBreak';
  static const String LONGBREAK = 'longBreak';

  late SharedPreferences prefs;

  TextEditingController txtWork = TextEditingController();
  TextEditingController txtShort = TextEditingController();
  TextEditingController txtlong = TextEditingController();

  TextStyle textStyle = const TextStyle(fontSize: 24);

  @override
  void initState() {
    super.initState();
    _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      txtWork.text = (prefs.getInt(WORKTIME) ?? 25).toString();
      txtShort.text = (prefs.getInt(SHORTBREAK) ?? 5).toString();
      txtlong.text = (prefs.getInt(LONGBREAK) ?? 15).toString();
    });
  }

  void _updateSetting(String key, int value) {
    setState(() {
      int currentValue = prefs.getInt(key) ?? 0;
      int updatedValue = currentValue + value;

      // Validation for bounds
      if (updatedValue >= 1 && updatedValue <= 180) {
        prefs.setInt(key, updatedValue);
        if (key == WORKTIME) txtWork.text = updatedValue.toString();
        if (key == SHORTBREAK) txtShort.text = updatedValue.toString();
        if (key == LONGBREAK) txtlong.text = updatedValue.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text(
            "Work",
            style: textStyle,
          ),
          const Text(''),
          const Text(''),
          SettingsButton(
              color: const Color(0xff455A64),
              text: '-',
              value: -1,
              setting: WORKTIME,
              callback: _updateSetting),
          TextField(
            controller: txtWork,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(
              color: const Color(0xff009688),
              text: '+',
              value: 1,
              setting: WORKTIME,
              callback: _updateSetting),
          Text(
            "Short",
            style: textStyle,
          ),
          const Text(''),
          const Text(''),
          SettingsButton(
            color: const Color(0xff455A64),
            text: '-',
            value: -1,
            setting: SHORTBREAK,
            callback: _updateSetting,
          ),
          TextField(
            controller: txtShort,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(
            color: const Color(0xff009688),
            text: '+',
            value: 1,
            setting: SHORTBREAK,
            callback: _updateSetting,
          ),
          Text(
            "Long",
            style: textStyle,
          ),
          const Text(''),
          const Text(''),
          SettingsButton(
            color: const Color(0xff455A64),
            text: '-',
            value: -1,
            setting: LONGBREAK,
            callback: _updateSetting,
          ),
          TextField(
            controller: txtlong,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(
            color: const Color(0xff009688),
            text: "+",
            value: 1,
            setting: LONGBREAK,
            callback: _updateSetting,
          ),
        ],
      ),
    );
  }
}
