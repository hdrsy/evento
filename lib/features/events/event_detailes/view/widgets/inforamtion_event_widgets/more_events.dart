import 'package:evento/core/shared/functions/lists/carouse_options_functions.dart';
import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/shared/widgets/lists/carousel_slider.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

Widget buildMoreEventsSection(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "More Events like this",
              style: customTextStyle.bodySmall.override(
                fontFamily: 'Open Sans',
                color: customColors.primaryText,
                fontSize: 16,
                useGoogleFonts: true,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                 "See All",
                style: customTextStyle.labelSmall.override(
                  fontFamily: breeSerif,
                  color: customColors.primary,
                  fontSize: 10,
                  useGoogleFonts: true,
                ),
              ),
            ),
          ],
        ),
      ),
      // Carousel or List of Additional Events
      // Placeholder for carousel/slider/list widget
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.23,
        child:
         buildListShow(
    body: List.generate(3, (index) => const MoreEventsCard()),
    carouselOptions:  CaroucelOptionFunctions.seeMoreEvents
  )
        //  ListView.builder(
        //   scrollDirection: Axis.horizontal,
        //   itemCount: 10, // Replace with actual item count
        //   itemBuilder: (context, index) {
        //     return MoreEventsCard();
        //   },
        // ),
      ),
    ],
  );
}
class MoreEventsCard extends StatelessWidget {
  const MoreEventsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this PlaceholderWidget Widget...
Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
  child: Container(
    width: 300,
    height: 200,
    decoration: BoxDecoration(
      color: customColors.secondaryBackground,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: customColors.tertiary,
      ),
    ),
    child: Align(
      alignment: const AlignmentDirectional(0.00, -1.00),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 130,
              decoration: const BoxDecoration(),
              child: Align(
                alignment: const AlignmentDirectional(1.00, -1.00),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        'assets/images/pexels-wolfgang-2747446.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        alignment: const Alignment(0.00, 1.00),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        // context.pushNamed('Event-Details');
                      },
                      child: Container(
                        width: 344,
                        height: 140,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0x9A2E4052), Color(0x0089CFF0)],
                            stops: [0, 1],
                            begin: AlignmentDirectional(0, -1),
                            end: AlignmentDirectional(0, 1),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                            child: ToggleIcon(
                              onPressed: () async {
                              
                              },
                              value: false,
                              onIcon: Icon(
                                Icons.favorite_rounded,
                                color: customColors.rejected,
                                size: 25,
                              ),
                              offIcon: Icon(
                                Icons.favorite_border,
                                color: customColors.info,
                                size: 25,
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
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 24,
                    decoration: BoxDecoration(
                      color: customColors.primaryBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0.00, 0.00),
                      child: Text(
                        " 300,000 s.p",
                        textAlign: TextAlign.center,
                        style: customTextStyle
                            .bodyMedium
                            .override(
                              fontFamily: breeSerif,
                              color: customColors.primaryText,
                              useGoogleFonts: false,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          " All Points East",
                          style: customTextStyle
                              .headlineSmall
                              .override(
                                fontFamily: breeSerif,
                                fontSize: 16,
                                useGoogleFonts: false,
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // context.pushNamed('Reels');
                              },
                              child: Icon(
                                Icons.play_arrow_outlined,
                                color:
                                    customColors.primaryText,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Wed 18 Aug",
                            style: customTextStyle
                                .bodyMedium
                                .override(
                                  fontFamily: breeSerif,
                                  color: customColors.primary,
                                  fontSize: 12,
                                  useGoogleFonts: false,
                                ),
                          ),
                          Text(
                             "22:00 PM",
                            style: customTextStyle
                                .bodyMedium
                                .override(
                                  fontFamily: breeSerif,
                                  color: customColors.primary,
                                  fontSize: 12,
                                  useGoogleFonts: false,
                                ),
                          ),
                        ].divide(const SizedBox(width: 5)),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            // context.pushNamed('Event-Details');
                          },
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            color: customColors.secondaryText,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
)
;
  }
}