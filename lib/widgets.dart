import 'package:flutter/material.dart';

typedef CallBackSetting = void Function(String, int);

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  //  double size;
  final VoidCallback onPressed;
  const ProductivityButton(
      {super.key,
      required this.color,
      required this.text,
      // required this.size,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      // minWidth: size,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final double? size;
  final int value;
  final String setting;
  final CallBackSetting callback;
  const SettingsButton(
      {super.key,
       this.size,
      required this.color,
      required this.text,
      required this.value,
      required this.setting,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        callback(setting, value);
      },
      color: color,
      minWidth: size,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
