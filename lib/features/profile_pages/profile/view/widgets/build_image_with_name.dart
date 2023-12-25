import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/features/profile_pages/profile/controller/profile_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildImageWithName() {
  final ProfileController profileController = Get.find();

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
            child: profileController.profileModel.image.length > 6
                ? getImageNetwork(
                    url: "/storage/${profileController.profileModel.image}",
                    width: null,
                    height: null)
                : Image.asset(
                    'assets/images/${profileController.profileModel.image}.png')),
        Positioned(
          bottom: 0,
          left: 0,
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Get.toNamed('/EditProfileScreen',arguments: profileController.profileModel);
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
        "${profileController.profileModel.firstName} ${profileController.profileModel.lastName}",
        style: customTextStyle.bodyLarge
            .copyWith(color: customColors.primary, fontSize: 18),
      ),
      Text(
        "ID#${profileController.profileModel.id}",
        style: customTextStyle.bodyLarge
            .copyWith(color: customColors.secondaryText, fontSize: 12),
      ),
    ],
  );
}
