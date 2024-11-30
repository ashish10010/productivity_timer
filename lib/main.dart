import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:productivity_timer/settings.dart';
import 'package:productivity_timer/timer.dart';
import 'package:productivity_timer/timermodel.dart';
import 'package:productivity_timer/widgets.dart';

void main() {
  runApp(const MyApp());
}

const double defaultPadding = 5.0;
final CountDownTimer timer = CountDownTimer();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      title: 'Productivity Timer',
      home: const TimerHomePage(),
    );
  }
}

void goToSettings(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      ));
}

class TimerHomePage extends StatelessWidget {
  const TimerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = [];
    menuItems.add(
      const PopupMenuItem(
        value: 'Settings',
        child: Text('Settings'),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Work Timer'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              if (s == 'Settings') {
                goToSettings(context);
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double availableWidth = constraints.maxWidth;
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff009688),
                      text: 'Work',
                      onPressed: () => timer.startWork(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff607D8B),
                      text: 'Short Break',
                      onPressed: () => timer.startBreak(true),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff455A64),
                      text: 'Long Break',
                      onPressed: () => timer.startBreak(false),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
              StreamBuilder(
                initialData: '00:00',
                stream: timer.stream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  TimerModel timer = (snapshot.data == '00:00')
                      ? TimerModel(1, '00:00')
                      : snapshot.data;
                  return Expanded(
                    child: CircularPercentIndicator(
                      radius: availableWidth / 3,
                      lineWidth: 10.0,
                      percent: timer.percent,
                      center: Text(
                        timer.time,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      progressColor: const Color(0xff009688),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff212121),
                      text: 'Stop',
                      onPressed: () => timer.stopTimer(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff009688),
                      text: 'Restart',
                      onPressed: () => timer.startTimer(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
