// ignore_for_file: prefer_const_constructors

import 'package:evento/main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyHours extends StatelessWidget {
  int hours;
  bool isCenterItem;

  MyHours({required this.hours,required this.isCenterItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        width: double.infinity,
        child: Center(
          child: Text(
            hours.toString(),
            style: TextStyle(
              fontSize: 20,
              color:   isCenterItem?customColors.primaryBtnText:customColors.primaryText
      ,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}