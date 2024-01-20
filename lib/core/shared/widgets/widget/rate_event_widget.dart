import 'package:evento/core/server/review_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/widget/rating_feedback_widget.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class ReviewEventWidget extends StatelessWidget {
  const ReviewEventWidget({
    Key? key, required this.ratingTarget, required this.url, required this.id, required this.idKey,
   
  }) : super(key: key);

  final String ratingTarget;
  final String url;
  final int id;
  final String idKey;
  @override
  Widget build(BuildContext context) {
    double ratingValue=0;
    TextEditingController comment=TextEditingController();
 
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        boxShadow: const[
          BoxShadow(
            blurRadius: 6,
            color: Color(0x35000000),
            offset: Offset(0, -2),
          )
        ],
        borderRadius:const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 50,
                child: Divider(
                  thickness: 3,
                  color: customColors.secondary,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                         "Rate $ratingTarget",
                        textAlign: TextAlign.start,
                        style: customTextStyle.headlineSmall,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        "Let us know what you thought o...",
                        textAlign: TextAlign.start,
                        style: customTextStyle.bodyMedium,
                      ).tr(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                           "How would you rate it?",
                          textAlign: TextAlign.start,
                          style: customTextStyle.bodySmall,
                        ).tr(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: RatingBar.builder(
                  onRatingUpdate: (value){
                    ratingValue=value;
                  },
                  itemBuilder: (context, index) => Icon(
                    Icons.star_rounded,
                    color: customColors.primary,
                  ),
                  direction: Axis.horizontal,
                  initialRating:  0,
                  unratedColor: customColors.primaryBackground,
                  itemCount: 5,
                  itemSize: 48,
                  glowColor: customColors.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: TextFormField(
                  controller: comment,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText:tr( "Please leave a description of ..."),
                    hintStyle: customTextStyle.bodyMedium,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: customColors.primaryBackground,
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

                   bool state= await review(url: url, rating: ratingValue.toInt(), desc: comment.text, idKey: idKey, id: id) ;
              state?  {
                Get.back(),
                    showButtonSheet(context: context, widget:  RateingFeedbackWidget(userRatingl: ratingValue), height: MediaQuery.sizeOf(context).height * 0.8)}:Get.back();
                    },
                  text:tr(  "Submit Review"),
                  options: ButtonOptions(
                    height: 45,
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: customColors.primary,
                    textStyle: customTextStyle.bodyMedium.override(
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
    );
  }
}
