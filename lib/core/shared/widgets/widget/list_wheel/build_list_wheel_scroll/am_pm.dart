// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class AmPm extends StatelessWidget {
  final bool isItAm;
  final bool isCenterItem;

  const AmPm({super.key, required this.isItAm, required this.isCenterItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
        child: Text(
          isItAm == true ? 'am' : 'pm',
          style: TextStyle(
            fontSize: 20,
            color: isCenterItem
                ? customColors.primaryBtnText
                : customColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ).tr(),
      ),
    );
  }
}
