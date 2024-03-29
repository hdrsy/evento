import '../../../../main.dart';
import 'package:flutter/material.dart';

class IconWithContainer extends StatelessWidget {
   const IconWithContainer({super.key,
  required this.icon,
   this.onTap,
  required this.buttonSize,
  required this.borderRadius,
  required this.backgroundColor,
  this.iconColor
  });
  final IconData icon;
  final Function()? onTap;
  final double buttonSize;
  final double borderRadius;
  final Color backgroundColor;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(width: 1, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))
            
            ),
        child: Icon(
          icon,
          color:iconColor?? customColors.primary,
          size: 24,
        ),
      )
    );
  }
}
