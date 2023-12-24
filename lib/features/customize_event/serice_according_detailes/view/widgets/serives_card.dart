import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return
InkWell(
  splashColor: Colors.transparent,
  focusColor: Colors.transparent,
  hoverColor: Colors.transparent,
  highlightColor: Colors.transparent,
  onTap: () async {
    
    Get.toNamed('/GalleryScreen');
  },
  child: SizedBox(
    width: double.infinity,
    child: Stack(
      alignment: const AlignmentDirectional(0, 0),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/unique-and-exciting-adult-birthday-party-ideas-hero-image.webp',
            width: 340,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Opacity(
          opacity: 0.4,
          child: Align(
            alignment: const AlignmentDirectional(0.11, 0.00),
            child: Container(
              width: 342,
              height: 200,
              decoration: BoxDecoration(
                color: customColors.secondaryBackground,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.01, -0.04),
          child: Text(
             "Birthday",
            style:customTextStyle.bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: customColors.primaryText,
                  fontSize: 30,
                  useGoogleFonts: true,
                ),
          ),
        ),
      ],
    ),
  ),
)
;
  }
}