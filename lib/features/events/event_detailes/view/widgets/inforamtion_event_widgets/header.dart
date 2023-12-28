import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/widget/invite_friends.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildHeader(BuildContext context, String eventTitle) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Align(
        alignment: const AlignmentDirectional(-1.00, -1.00),
        child: Text(
          eventTitle,
          style: customTextStyle.displaySmall,
        ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
      ),
      NumberOfGoingAndInviteFriendsButton()
    ],
  );
}

class NumberOfGoingAndInviteFriendsButton extends StatelessWidget {
  NumberOfGoingAndInviteFriendsButton({super.key});
  final EventDetailesController eventDetailesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
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
            Get.toNamed('/GoingScreen');
          },
          child: Container(
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DynamicImageStack(),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: Text(
                    "${eventDetailesController.eventDetailsModel.bookings.length} +",
                    style: customTextStyle.bodySmall.override(
                        fontFamily: 'Open Sans',
                        color: const Color(0xFF8B97A2),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts: true),
                  ),
                ),
                Icon(
                  Icons.arrow_right_alt,
                  color: customColors.secondaryText,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        ButtonWidget(
          onPressed: () async {
            showButtonSheet(context: context, widget: InviteFreinds(), height: screenHeight*0.2);
          },
          text: "Invite Friend",
          options: ButtonOptions(
            width: 109,
            height: 21,
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: customColors.primary,
            textStyle: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: customColors.info,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              useGoogleFonts: true,
            ),
            borderSide: BorderSide(
              color: customColors.primary,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    ).animateOnPageLoad(animationsMap['rowOnPageLoadAnimation1']!);
  }
}

class GoingImage extends StatelessWidget {
  const GoingImage({super.key, required this.imgUrl});
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        imgUrl,
        fit: BoxFit.contain,
      ),
    );
  }
}

class DynamicImageStack extends StatelessWidget {
  EventDetailesController eventDetailesController = Get.find();
  DynamicImageStack({
    Key? key,
  }) : super(key: key);

  List<Widget> _buildImageStack() {
    List<Widget> widgets = [];

    for (int i = 0;
        i < eventDetailesController.eventDetailsModel.bookings.length &&
            i < 3;
        i++) {
      double alignmentValue = -1 + (i * 0.27); // Adjust this value as needed
      widgets.add(
        Align(
          alignment: AlignmentDirectional(alignmentValue, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(i * 15, 0, 0, 0),
            child: Container(
              width: 28,
              height: 28,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const GoingImage(
                  imgUrl: 'assets/images/faceBookProfile.jfif'),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const AlignmentDirectional(-1, 0),
      children: _buildImageStack(),
    );
  }
}
