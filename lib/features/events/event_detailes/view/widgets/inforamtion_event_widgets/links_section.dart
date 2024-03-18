import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../../core/utils/theme/text_theme.dart';
import '../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LinksSection extends StatelessWidget {
  LinksSection({super.key});
  final EventDetailesController eventDetailesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      eventDetailesController.eventDetailsModel.webSite != null
          ? LinkCard(
              icon: Icons.language_outlined,
              title: eventDetailesController.eventDetailsModel.webSite ?? "",
              isLink: true,
            )
          : const SizedBox.shrink(),
      eventDetailesController.eventDetailsModel.webSite != null
          ? const SizedBox(
              height: 16,
            )
          : const SizedBox.shrink(),

      eventDetailesController.eventDetailsModel.facebook != null
          ? LinkCard(
              icon: Icons.facebook,
              isLink: true,
              title: eventDetailesController.eventDetailsModel.facebook!,
            )
          : const SizedBox.shrink(),
      eventDetailesController.eventDetailsModel.facebook != null
          ? const SizedBox(
              height: 16,
            )
          : const SizedBox.shrink(),
      eventDetailesController.eventDetailsModel.instagram != null
          ? LinkCard(
              icon: 'assets/images/Instagram.png',
              title: eventDetailesController.eventDetailsModel.instagram!,
              isLink: true,
            )
          : const SizedBox.shrink(),
      eventDetailesController.eventDetailsModel.instagram != null
          ? const SizedBox(
              height: 16,
            )
          : const SizedBox.shrink(),
//          LinkCard(
//           icon: Icons.payment,
//           title:tr( "Deposit information"),
//           subTitle: """\$50 deposit per person is required to be
// paid in advance and will be deducted
// from your check.""",
//         ),
      eventDetailesController.eventDetailsModel.refundPlicy != null
          ? LinkCard(
              icon: Icons.refresh_outlined,
              title: tr("Refund policy"),
              subTitle: eventDetailesController.eventDetailsModel.refundPlicy,
            )
          : const SizedBox.shrink(),
      eventDetailesController.eventDetailsModel.refundPlicy != null
          ? const SizedBox(
              height: 16,
            )
          : const SizedBox.shrink(),
      eventDetailesController.eventDetailsModel.cancellationPolicy != null
          ? LinkCard(
              icon: Icons.cancel_presentation_outlined,
              title: tr("Cancellation policy"),
              subTitle:
                  eventDetailesController.eventDetailsModel.cancellationPolicy!,
            )
          : const SizedBox.shrink(),
    ]);
  }
}

// ignore: must_be_immutable
class LinkCard extends StatelessWidget {
  LinkCard(
      {super.key,
      required this.icon,
      required this.title,
      this.subTitle,
      this.isLink = false});
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  final String title;
  final String? subTitle;
  bool isLink;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isLink ? Get.find<EventDetailesController>().openLink(title) : null;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: customColors.border, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                child: icon is String
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          icon,
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        icon,
                        color: customColors.primary,
                        size: 20,
                      ),
              ),
              SizedBox(
                width: 300.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: customTextStyle.bodyMedium.copyWith(fontSize: 14),
                    ),
                    subTitle != null
                        ? Text(
                            subTitle ?? "",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: primaryFontFamily,
                              fontSize: 12,
                              useGoogleFonts: true,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
