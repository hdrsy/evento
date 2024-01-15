import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LinearPercentIndicatorWidget4 extends StatelessWidget {
  const LinearPercentIndicatorWidget4({super.key});

  @override
  Widget build(BuildContext context) {
    return 
Row(
  mainAxisAlignment: MainAxisAlignment.center,
 children:  [ LinearPercentIndicator(
  
    percent: 0.8,
  
    width: 120,
  
    lineHeight: 8,
  
    animation: true,
  
    animateFromLastPercent: true,
  
    progressColor: customColors.primary,
  
    backgroundColor: customColors.primaryBackground,
  
    barRadius: const Radius.circular(12),
  
    padding: EdgeInsets.zero,
  
  )],
)
;
  }
}