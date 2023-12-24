import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/animation/animation_def.dart';
import 'package:evento/core/utils/animation/animation_util.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildPageView extends StatelessWidget {
  const BuildPageView({super.key,required this.controller});
 final PageController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 1,
      child: PageView(
        controller: controller,
        children: [
          buildTextAndImageInBackGround(
              context: context,
              title: "Unearth Upcoming Events",
              smallTitle:
                  "Dive deep into a curated list of events, workshops, and festivals happening around you or anywhere in the world.",
              imagePath:
                  "assets/images/excited-audience-watching-confetti-fireworks-having-fun-music-festival-night-copy-space.jpg"),
          buildTextAndImageInBackGround(
              context: context,
              title: "Tailored Just for You",
              smallTitle:
                  "Based on your interests and preferences, get personalized event recommendations that match your vibe.",
              imagePath:
                  "assets/images/Encore_EventType_TheatreConcertandSpecialEvents_4.jpg"),
          buildTextAndImageInBackGround(
              context: context,
              title: "Never Miss a Moment",
              smallTitle:
                  " Receive real-time notifications about your booked events, reminders, and updates from event organizers.",
              imagePath:
                  "assets/images/[fpdl.in]_view-from-back-unrecognizable-people-warm-clothes-shooting-fireworks-phone-night_636705-315_normal.jpg"),
        ],
      ),
    );
  }
}

Widget buildTextAndImageInBackGround(
    {required BuildContext context,
    required String title,
    required String smallTitle,
    required String imagePath}) {
  return Stack(
    children: [
      Align(
        alignment: const AlignmentDirectional(0.00, 0.00),
        child: ClipRRect(
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: screenHeight,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(0.00, 1.00),
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 1,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 70,
                color: Colors.black,
                offset: Offset(0, 700),
                spreadRadius: 50,
              )
            ],
          ),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(0.00, 0.60),
        child: Container(
          alignment: Alignment.center,
          height: scaleHeight(150),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Text(
                  title,
                  style: customTextStyle.headlineSmall.copyWith(
                      color: customColors.info,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
              ),
              SizedBox(
                height: scaleHeight(0),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 40),
                child: Text(
                  smallTitle,
                  textAlign: TextAlign.center,
                  style: customTextStyle.bodySmall.copyWith(
                      color: customColors.info,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation2']!),
              ),
            ],
          ),
        ),
      )
    ],
  );
}
