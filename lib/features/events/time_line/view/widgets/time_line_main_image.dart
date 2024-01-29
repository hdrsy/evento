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
        height: 300,
        // color: Colors.amber,
        child: GestureDetector(
          onTap: () async {
            // await Navigator.push(
            //   context,
            //   PageTransition(
            //     type: PageTransitionType.fade,
            //     child: FlutterFlowExpandedImageView(
            //       image: Image.asset(
            //         'assets/images/Austin_Banger_s_Sausage_House_Beer_Garden_508dc4f0-5a14-47d7-80ba-304bb9f18bf0.jpg',
            //         fit: BoxFit.contain,
            //       ),
            //       allowRotation: false,
            //       tag: valueOrDefault<String>(
            //         widget.propertyRef?.mainImage,
            //         'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/oowrriphtb4n/hero_home@3x.jpg',
            //       ),
            //       useHeroAnimation: true,
            //     ),
            //   ),
            // );
          },
          // child: Hero(
          //   tag: valueOrDefault<String>(
          //     widget.propertyRef?.mainImage,
          //     'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/oowrriphtb4n/hero_home@3x.jpg',
          //   ),
          //   transitionOnUserGestures: true,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: getImageNetwork(
                      url: imgUrl, width: double.infinity, height: null)),
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
          ),
        ),
      ),
      // ),
    );
  }
}
