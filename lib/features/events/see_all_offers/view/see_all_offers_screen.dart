import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAllOffersScreen extends StatelessWidget {
  const SeeAllOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Offers",
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               ...List.generate(4, (index) =>const SeeAllOffersCard())
          ].divide(
Divider(
  height: 30,
  thickness: 1,
  indent: 12,
  endIndent: 12,
  color:customColors.secondary,
)
),
        ),
      ),
    );
  }
}

class SeeAllOffersCard extends StatelessWidget {
  const SeeAllOffersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return
 Container(
          width: double.infinity,
          height: screenHeight*0.25,
          decoration: BoxDecoration(
            color:customColors.secondaryBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:customColors.secondaryBackground,
            ),
          ),
  child:   Column(
  
    mainAxisSize: MainAxisSize.max,
  
    children: [
  
      Expanded(
  
        child: Align(
  
          alignment: const AlignmentDirectional(0, -1),
  
          child: Container(
  
            width: double.infinity,
  
            height: double.infinity,
  
            child: Stack(
  
              children: [
  
                InkWell(
  
                  splashColor: Colors.transparent,
  
                  focusColor: Colors.transparent,
  
                  hoverColor: Colors.transparent,
  
                  highlightColor: Colors.transparent,
  
                  onTap: () async {
  
                    // context.pushNamed('Offers-Details');
  
                  },
  
                  child: ClipRRect(
  
                    borderRadius: const BorderRadius.only(
  
                      bottomLeft: Radius.circular(0),
  
                      bottomRight: Radius.circular(0),
  
                      topLeft: Radius.circular(20),
  
                      topRight: Radius.circular(20),
  
                    ),
  
                    child: Image.asset(
  
                      'assets/images/entertainment.jpeg',
  
                      width: double.infinity,
  
                      height: 400,
  
                      fit: BoxFit.cover,
  
                    ),
  
                  ),
  
                ),
  
                Padding(
  
                  padding: const EdgeInsets.all(16),
  
                  child: Row(
  
                    mainAxisSize: MainAxisSize.max,
  
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
                    crossAxisAlignment: CrossAxisAlignment.start,
  
                    children: [
  
                      Container(
  
                        width: 60,
  
                        height: 30,
  
                        decoration: BoxDecoration(
  
                          color:customColors.primary,
  
                          borderRadius: BorderRadius.circular(16),
  
                        ),
  
                        child: Align(
  
                          alignment: const AlignmentDirectional(0, 0),
  
                          child: Text(
  
                             "Offer",
  
                            textAlign: TextAlign.center,
  
                            style: customTextStyle
  
                                .bodyMedium
  
                                .override(
  
                                  fontFamily: 'Nunito',
  
                                  color:customColors.info,
  
                                  fontSize: 14,
  
                                  fontWeight: FontWeight.bold,
  
                                  useGoogleFonts: false,
  
                                ),
  
                          ),
  
                        ),
  
                      ),
  
                    ],
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ),
  
      Padding(
  
        padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
  
        child: Row(
  
          mainAxisSize: MainAxisSize.max,
  
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
          children: [
  
            Column(
  
              mainAxisSize: MainAxisSize.max,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children: [
  
                Align(
  
                  alignment: const AlignmentDirectional(0, 0),
  
                  child: Row(
  
                    mainAxisSize: MainAxisSize.max,
  
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
                    crossAxisAlignment: CrossAxisAlignment.center,
  
                    children: [
  
                      Text(
  
                         "All Points East",
  
                        style:
  
                            customTextStyle.headlineSmall.override(
  
                                  fontFamily: 'Nunito',
  
                                  color:customColors.primary,
  
                                  useGoogleFonts: false,
  
                                ),
  
                      ),
  
                    ],
  
                  ),
  
                ),
  
                Row(
  
                  mainAxisSize: MainAxisSize.max,
  
                  children: [
  
                    Text(
  
                       "Wed 18 Aug",
  
                      style: customTextStyle.bodyMedium.override(
  
                            fontFamily: 'Nunito',
  
                            color:customColors.secondaryText,
  
                            fontWeight: FontWeight.w500,
  
                            useGoogleFonts: false,
  
                          ),
  
                    ),
  
                    Text(
  
                       "22:00 PM",
  
                      style: customTextStyle.bodyMedium.override(
  
                            fontFamily: 'Nunito',
  
                            color:customColors.secondaryText,
  
                            fontWeight: FontWeight.w500,
  
                            useGoogleFonts: false,
  
                          ),
  
                    ),
  
                  ].divide(const SizedBox(width: 5)),
  
                ),
  
                InkWell(
  
                  splashColor: Colors.transparent,
  
                  focusColor: Colors.transparent,
  
                  hoverColor: Colors.transparent,
  
                  highlightColor: Colors.transparent,
  
                  onTap: () async {
  
                    // context.pushNamed('Event-Location');
  
                  },
  
                  child: Row(
  
                    mainAxisSize: MainAxisSize.max,
  
                    mainAxisAlignment: MainAxisAlignment.start,
  
                    children: [
  
                      Icon(
  
                        Icons.location_on_outlined,
  
                        color:customColors.secondaryText,
  
                        size: 15,
  
                      ),
  
                      Text(
  
                         "Damascus, Malki, Skystone",
  
                        style: customTextStyle.bodyMedium.override(
  
                              fontFamily: 'Nunito',
  
                              color:customColors.secondaryText,
  
                              fontWeight: FontWeight.normal,
  
                              useGoogleFonts: false,
  
                            ),
  
                      ),
  
                    ],
  
                  ),
  
                ),
  
              ].divide(const SizedBox(height: 2)),
  
            ),
  
            Align(
  
              alignment: const AlignmentDirectional(1, -1),
  
              child: Container(
  
                width: 35,
  
                height: 35,
  
                decoration: BoxDecoration(
  
                  color:customColors.primary,
  
                  shape: BoxShape.circle,
  
                ),
  
                child: ToggleIcon(
  
                  onPressed: () async {
  
                   },
  
                  value: false,
  
                  onIcon: Icon(
  
                    Icons.favorite_sharp,
  
                    color: customColors.error,
  
                    size: 20,
  
                  ),
  
                  offIcon: Icon(
  
                    Icons.favorite_border,
  
                    color: customColors.primaryBackground,
  
                    size: 20,
  
                  ),
  
                ),
  
              ),
  
            ),
  
          ],
  
        ),
  
      ),
  
    ],
  
  ),
)
;  }
}
