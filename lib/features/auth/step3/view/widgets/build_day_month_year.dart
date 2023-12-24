import 'package:evento/main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DayMonthYear extends StatelessWidget {
   DayMonthYear({super.key,required this.value});
  String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: customTextStyle.bodyMedium
              .copyWith(color: customColors.secondaryText, fontSize: 14),
        ),
        Icon(
          Icons.keyboard_arrow_down_rounded,
          color: customColors.secondaryText,
          size: 20,
        ),
      ],
    );
  }
}
