import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/shared/widgets/buttons/icon_with_container.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeLineMainImage extends StatelessWidget {
  const TimeLineMainImage({super.key, required this.imgUrl});
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return // Generated code for this mainImage Widget...
        Align(
      alignment: const AlignmentDirectional(0.00, 0.00),
      child: SizedBox(
        width: double.infinity,
        height: 300.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: getImageNetwork(
                    url: imgUrl, width: double.infinity, height: null)),
            Align(
              alignment: const AlignmentDirectional(-0.9, -0.6),
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
        ),
      ),
      // ),
    );
  }
}
