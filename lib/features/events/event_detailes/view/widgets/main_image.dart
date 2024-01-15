import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/buttons/icon_with_container.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key, required this.imgUrl});
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.4,
          child: Align(
            alignment: const AlignmentDirectional(0.00, 0.00),

            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {},
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: getImageNetwork(
                      url: imgUrl,
                      width: double.infinity,
                      height: double.infinity)

                  //  Image.asset(
                  //   'assets/images/alumni2.webp',
                  //   width: double.infinity,
                  //   height: double.infinity,
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            ),

            // ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-0.9, -0.9),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: const Color(0x3A000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconWithContainer(
              backgroundColor: Colors.transparent,
              buttonSize: 46,
              borderRadius: 10,
              icon: Icons.arrow_back_rounded,
              iconColor: customColors.info,
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
      ],
    );
  }
}
