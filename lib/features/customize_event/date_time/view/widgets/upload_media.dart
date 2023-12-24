import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class UploadMedia extends StatelessWidget {
  const UploadMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Container Widget...
Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
  child: Container(
    width: 360,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: customColors.primaryBackground,
      ),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                   "Upload Media",
                  textAlign: TextAlign.center,
                  style: customTextStyle.labelLarge.override(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts: true,
                      ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      
                    },
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      color: customColors.secondaryText,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://picsum.photos/seed/46/600',
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/Austin_Banger_s_Sausage_House_Beer_Garden_508dc4f0-5a14-47d7-80ba-304bb9f18bf0.jpg',
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/pexels-clem-onojeghuo-111287.jpg',
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
)
;
  }
}