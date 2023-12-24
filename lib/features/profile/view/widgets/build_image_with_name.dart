import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildImageWithName() {
  return Column(
    children: [
      Stack(children: [
        Container(
          width: 80,
          height: 80,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            'https://picsum.photos/seed/171/600',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0, 
          left: 0,
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Get.toNamed('/EditProfileScreen');
            },
            child: Container(
              padding: padding(5, 5, 5, 5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: customColors.secondaryBackground),
              child: Icon(
                Icons.edit_outlined,
                color: customColors.primaryText,
                size: 20,
              ),
            ),
          ),
        ),
      ]),
      SizedBox(
        height: scaleHeight(5),
      ),
      Text(
        "Maysam",
        style: customTextStyle.bodyLarge
            .copyWith(color: customColors.secondaryText, fontSize: 20),
      )
    ],
  );
}
