import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RateingFeedbackWidget extends StatelessWidget {
  const RateingFeedbackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
            boxShadow: const[
               BoxShadow(
                blurRadius: 6,
                color: Color(0x35000000),
                offset: Offset(0, -2),
              )
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: customColors.primary,
                    size: 150,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                             "Thank You for Your Feedback!",
                            textAlign: TextAlign.center,
                            style: customTextStyle.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: RatingBar.builder(
                      onRatingUpdate: (newValue) {},
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rounded,
                        color: customColors.primary,
                      ),
                      direction: Axis.horizontal,
                      initialRating:  0,
                      unratedColor: customColors.primary,
                      itemCount: 5,
                      itemSize: 48,
                      glowColor: customColors.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText:  "Please leave a description of ...",
                        hintStyle: customTextStyle.bodyMedium,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                customColors.primaryBackground,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: customTextStyle.bodySmall,
                      maxLines: 4,
        ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                    child: ButtonWidget(
                      onPressed: () async {
                        // context.pushNamed('Booking-Details');
                        Get.back();
                      },
                      text:  "Done",
                      options: ButtonOptions(
                        height: 45,
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.primary,
                        textStyle:
                            customTextStyle.bodyMedium.override(
                                  fontFamily: 'Nunito',
                                  color: customColors.info,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: true,
                                ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['buttonOnPageLoadAnimation']!),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
