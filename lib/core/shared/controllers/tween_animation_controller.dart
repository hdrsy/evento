import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TweenAnimationController extends GetxController with GetSingleTickerProviderStateMixin{
    late AnimationController aController;
        late Animation<double> aCurve;  
  late Animation<Color?> aColor;
  late Animation<double?> aSize;

  @override
  void onInit() {
    super.onInit();

    aController = AnimationController(
      vsync: this, duration: const Duration(milliseconds:1000));
    aCurve =
      CurvedAnimation(parent: aController, curve: Curves.slowMiddle);
    aColor =
      ColorTween(begin: Colors.grey, end: Colors.red).animate(aCurve);
    aSize = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 30, end: 100), weight: 50),
    TweenSequenceItem(tween: Tween(begin: 100, end: 30), weight: 50),
  ]).animate(aCurve);
  }
}