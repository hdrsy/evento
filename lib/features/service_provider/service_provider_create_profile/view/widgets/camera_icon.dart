import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class CameraIconCard extends StatelessWidget {
  const CameraIconCard({super.key, required this.onTap});
final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: customColors.primaryBackground,
            shape: BoxShape.circle,
            border: Border.all(
              color: customColors.secondaryBackground,
            ),
          ),
          child: Icon(
            Icons.camera_alt,
            color: customColors.primaryText,
            size: 15,
          ),
        ),
      ),
    );
  }
}