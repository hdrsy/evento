import 'package:evento/core/shared/widgets/buttons/icon_with_container.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueCard extends StatelessWidget {
  const VenueCard({super.key});
  @override
  Widget build(BuildContext context) {
    return 
Stack(
  alignment: const AlignmentDirectional(0, 1),
  children: [
    Container(
      
      height: 138,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: const AlignmentDirectional(0.00, 0.20),
          image: Image.asset(
            'assets/images/pexels-asad-photo-maldives-169189.jpg',
          ).image,
        ),
        boxShadow:const [
           BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    Container(
      
      height: 138,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF050606), Color(0x00EE8B60)],
          stops: [0, 0.7],
          begin: AlignmentDirectional(-1, 0),
          end: AlignmentDirectional(1, 0),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                     "Venue",
                    style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: customColors.info,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: false,
                        ),
                  ),
                  Text(
                    "Select a picturesque setting for your special day",
                    style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.info,
                          fontSize: 12,
                          useGoogleFonts: true,
                        ),
                  ),
                ].divide(const SizedBox(height: 5)),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconWithContainer(
                  borderRadius: 20,
                  buttonSize: 40,
                  iconColor: customColors.info,
                   backgroundColor: customColors.primary,
                  icon: 
                    Icons.arrow_forward,
                   
                  
                  onTap: () async {
                    // context.pushNamed('Venuelist');
                    Get.toNamed('/ServiceAccordingCategoryScreen');
                  },
                ),
              ].addToEnd(const SizedBox(height: 30)),
            ),
          ].divide(const SizedBox(width: 60)),
        ),
      ),
    ),
  ],
)
;
  }
}