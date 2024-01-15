import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class OrganizerConditionsWidget extends StatelessWidget {
  const OrganizerConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 16),
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
              Align(
                alignment: const AlignmentDirectional(-1.00, -1.00),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Text(
                    "Organizer",
                    style: customTextStyle.headlineMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primaryText,
                      useGoogleFonts: true,
                    ),
                  ).tr(),
                ),
              ),
              const WhatIsAnorganizer(),
              const WhatDoesBecominganOrganize(),
              const ExclusiveFeaturesforOrganizer(),
              const Buttons(),
            ]
                .divide(const SizedBox(height: 16))
                .addToStart(const SizedBox(height: 16))
                .addToEnd(const SizedBox(height: 16)),
          ),
        ),
      ),
    );
  }
}

class ExclusiveFeaturesforOrganizer extends StatelessWidget {
  const ExclusiveFeaturesforOrganizer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Text(
            "Exclusive Features for Organizers:",
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Nunito',
              color: customColors.primaryText,
              useGoogleFonts: true,
            ),
          ).tr(),
        ),
        Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Text(
            """ Cultivate Your Community: Develop a loyal following by creating a dynamic Organizer profile. Share your event philosophy, success stories, and upcoming plans to engage and grow your audience.

Unlimited Event Creation: Your creativity shouldn't have boundaries. With the ability to manage multiple events, the sky's the limit. Each event can be a distinct adventure, tailored to different interests and scales.

Direct Interaction with Attendees: Connect with your audience directly within the app. Gather valuable feedback, address inquiries, and foster a community that's centered around your events.

Enhanced Exposure: As an Organizer, you'll benefit from increased visibility. Your events will be featured prominently, ensuring they reach the right audience and achieve maximum attendance.

In-Depth Analytics: Measure your impact with comprehensive analytics. Understand attendee behavior, engagement levels, and gather feedback to continuously refine and elevate your events.

Seamless Collaborations: Effortlessly coordinate with vendors, sponsors, and fellow organizers. Our platform is designed for efficient communication and collaboration, making your planning process smooth and enjoyable.

Dedicated Support: Whenever you need assistance or advice, our support team is just a message away, ready to assist you in making your event a grand success.
""",
            style: customTextStyle.bodyMedium,
          ).tr(),
        ),
      ].divide(const SizedBox(height: 5)),
    );
  }
}

class WhatDoesBecominganOrganize extends StatelessWidget {
  const WhatDoesBecominganOrganize({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Text(
            "What Does Becoming an Organizer Entail?",
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Nunito',
              color: customColors.primaryText,
              useGoogleFonts: true,
            ),
          ).tr(),
        ),
        Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Text(
            "Embracing the role of an Organizer means you are ready to take the lead in crafting events that resonate and inspire. It's about bringing your unique vision to life and creating spaces where stories unfold and connections are made.",
            style: customTextStyle.bodyMedium,
          ).tr(),
        ),
      ].divide(const SizedBox(height: 5)),
    );
  }
}

class WhatIsAnorganizer extends StatelessWidget {
  const WhatIsAnorganizer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Text(
            "What is an Organizer?",
            style: customTextStyle.bodyMedium.override(
              fontFamily: 'Nunito',
              color: customColors.primaryText,
              useGoogleFonts: true,
            ),
          ).tr(),
        ),
        Align(
          alignment: const AlignmentDirectional(-1.00, -1.00),
          child: Text(
            "An Organizer is more than just a planner; they are creators of experiences and architects of memories. If you have a flair for orchestrating events and a desire to bring people together, this role is tailored for you.",
            style: customTextStyle.bodyMedium,
          ).tr(),
        ),
      ].divide(const SizedBox(height: 5)),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonWidget(
          onPressed: () async {
            // Navigator.pop(context);
            Get.back();
          },
          text:tr( "Cancel"),
          options: ButtonOptions(
            height: 40,
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: customColors.primary,
            textStyle: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: Colors.white,
              useGoogleFonts: true,
            ),
            elevation: 3,
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        ButtonWidget(
          onPressed: () async {
            // context.pushNamed('Become-an-Organizer');
            Get.toNamed('/OrganizerCreateProfileScreen');
          },
          text:tr( "Confirm"),
          options: ButtonOptions(
            height: 40,
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: customColors.primary,
            textStyle: customTextStyle.titleSmall.override(
              fontFamily: 'Nunito',
              color: Colors.white,
              useGoogleFonts: true,
            ),
            elevation: 3,
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
