import '../../../../../core/utils/animation/animation_def.dart';
import '../../../../../core/utils/animation/animation_util.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/time_line_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
Widget buildHeaderTimeLine(BuildContext context) {
  TimeLineController timeLineController=Get.find();
   return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Align(
        alignment: const AlignmentDirectional(-1.00, -1.00),
        child: Text(
          timeLineController.eventDetailsModel.title,
          style: customTextStyle.displaySmall,
        ).animateOnPageLoad(
            animationsMap['textOnPageLoadAnimation']!),
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
              // context.pushNamed('Going');
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Text(
                     "10,000+",
                    style: customTextStyle
                        .bodySmall
                        .override(
                          fontFamily: 'Open Sans',
                          color: const Color(0xFF8B97A2),
                          fontSize: 12,
                          useGoogleFonts: true,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                  child: Text(
                     "Going",
                    style: customTextStyle
                        .bodySmall
                        .override(
                          fontFamily: 'Open Sans',
                          useGoogleFonts: true,
                          color: const Color(0xFF8B97A2),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                  ).tr(),
                ),
              ],
            ),
          ).animateOnPageLoad(
              animationsMap['rowOnPageLoadAnimation1']!),
          
        ].divide(const SizedBox(height: 5)),
      )
    ],
  );
  }