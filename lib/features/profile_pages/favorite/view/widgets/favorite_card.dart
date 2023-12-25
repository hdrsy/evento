import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: const [
            BoxShadow(
                color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 2)),
          ]),
      child: Column(
        children: [
          _buildImage(),
          _dateWithPlayVedio(),
          // Generated code for this Divider Widget...
          Divider(
            thickness: 1,
            indent: 12,
            endIndent: 12,
            color: customColors.secondary,
          ),
          _locationWithDistance()
        ],
      ),
    );
  }

  Widget _locationWithDistance() {
    return 
        Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: customColors.primary,
                  size: 18,
                ),
                Text(
                  "Damascus , Bab Sharqi , La Cap...",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: breeSerif,
                    color: customColors.primaryText,
                    fontSize: 12,
                    useGoogleFonts: true,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              // context.pushNamed('Going');
            },
            child: Text(
              "3.7 Km",
              style: customTextStyle.bodyMedium.override(
                fontFamily: breeSerif,
                color: customColors.primary,
                useGoogleFonts: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateWithPlayVedio() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Wed 18 Aug",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: breeSerif,
                      color: customColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts: true,
                    ),
                  ),
                ],
              ),
              Text(
                "22:00 PM ",
                style: customTextStyle.bodyMedium.override(
                  fontFamily: breeSerif,
                  fontSize: 12,
                  useGoogleFonts: true,
                ),
              ),
            ].divide(const SizedBox(width: 10)),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Icon(
                      Icons.play_arrow_outlined,
                      color: customColors.primaryText,
                      size: 20,
                    ),
                  ),
                  ToggleIcon(
                    onPressed: () async {},
                    value: false,
                    onIcon: Icon(
                      Icons.favorite_sharp,
                      color: customColors.error,
                      size: 25,
                    ),
                    offIcon: Icon(
                      Icons.favorite_border,
                      color: customColors.secondaryText,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Stack(alignment: const AlignmentDirectional(0, 1), children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Image.asset(
          'assets/images/alumni2.webp',
          width: double.infinity,
          height: scaleHeight(200),
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
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
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
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Marshmallow",
              style: customTextStyle.headlineSmall.override(
                fontFamily: breeSerif,
                color: customColors.info,
                fontWeight: FontWeight.w600,
                useGoogleFonts: true,
              ),
            ),
            Container(
              width: 80,
              height: 24,
              decoration: BoxDecoration(
                color: customColors.secondaryBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Align(
                alignment: const AlignmentDirectional(0.00, 0.00),
                child: Text(
                  "300,000 s.p",
                  textAlign: TextAlign.center,
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: breeSerif,
                    color: customColors.primaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
