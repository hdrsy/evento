import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class UserStories extends StatelessWidget {
  const UserStories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ...List.generate(8, (index) =>  ProfileColumn(
              imageUrl: 'assets/images/Screenshot_2023-10-05_114112.png',
              nameKey: 'Layal', // Replace with actual key
              borderColor: customColors.primary,
            ),)
           
            // Repeat for other profiles...
          ].divide(const SizedBox(width: 10)),
        ),
      ),
    );
  }
}

class ProfileCircle extends StatelessWidget {
  final String imageUrl;
  final Color borderColor;

  const ProfileCircle({super.key, required this.imageUrl, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: customColors.accent1,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset(
            imageUrl,
            width: 44,
            height: 44,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ProfileColumn extends StatelessWidget {
  final String imageUrl;
  final String nameKey;
  final Color borderColor;

  const ProfileColumn({super.key, required this.imageUrl, required this.nameKey, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ProfileCircle(imageUrl: imageUrl, borderColor: borderColor),
        Text(
          nameKey,
          style: customTextStyle.bodyMedium.override(
                fontFamily: 'Nunito',
                color: customColors.primaryText,
                useGoogleFonts: true,
              ),
        ),
      ],
    );
  }
}


