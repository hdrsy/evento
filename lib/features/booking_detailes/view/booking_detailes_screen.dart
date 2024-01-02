import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/buttons/icon_with_container.dart';
import 'package:evento/core/shared/widgets/widget/rate_event_widget.dart';
import 'package:evento/core/shared/widgets/widget/total_widget.dart';
import 'package:evento/core/utils/helper/expanded_image_view.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/booking_detailes/controller/booking_detailes_controller.dart';
import 'package:evento/features/booking_detailes/view/widget/build_buttons.dart';
import 'package:evento/features/booking_detailes/view/widget/event_info_card.dart';
import 'package:evento/features/booking_detailes/view/widget/ticket_detailes_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class BookingDetailesScreen extends StatelessWidget {
  BookingDetailesScreen({super.key});
  final BookingDetailesController bookingDetailesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Booking Detailes",
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary, fontSize: 20)),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: customColors.primaryText,
            size: 30,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: padding(16, 24, 0, 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Date Of Event",
                    style: customTextStyle.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              BookingInfo(),
              const SizedBox(
                height: 16,
              ),
              EventInfoCard(),
              ...List.generate(
                  bookingDetailesController.ticketList.length,
                  (index) => TicketDetailesCard(
                        ticketModel:
                            bookingDetailesController.ticketList[index],
                        modelIndex: index,
                      )),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Your booking has been completed",
                      style: customTextStyle.titleMedium,
                    ),
                    Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: BuildButton()),
                  ],
                ),
              ),
               const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingDetailes extends StatelessWidget {
  const BookingDetailes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Total Price",
                  style: customTextStyle.bodySmall.override(
                      fontFamily: 'Open Sans',
                      color: customColors.gray600,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts: true),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Base Price",
                  style: customTextStyle.bodySmall.override(
                      fontFamily: 'Open Sans',
                      color: const Color(0xFF8B97A2),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      useGoogleFonts: true),
                ),
                Text(
                  "156.000 sp",
                  style: customTextStyle.bodyLarge.override(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    useGoogleFonts: true,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Taxes",
                  style: customTextStyle.bodySmall.override(
                      fontFamily: 'Open Sans',
                      color: const Color(0xFF8B97A2),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      useGoogleFonts: true),
                ),
                Text(
                  "24.000 sp",
                  style: customTextStyle.bodyLarge.override(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    useGoogleFonts: true,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Discount",
                      style: customTextStyle.headlineSmall.override(
                          fontFamily: 'Lexend Deca',
                          color: customColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          useGoogleFonts: true),
                    ),
                  ],
                ),
                Text(
                  "20.000 sp",
                  style: customTextStyle.titleSmall.override(
                    fontFamily: 'Open Sans',
                    color: customColors.primary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Total",
                      style: customTextStyle.headlineSmall.override(
                          fontFamily: 'Open Sans',
                          color: const Color(0xFF8B97A2),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          useGoogleFonts: true),
                    ),
                    IconWithContainer(
                      borderRadius: 30,
                      backgroundColor: customColors.secondaryBackground,
                      buttonSize: 36,
                      icon: Icons.info_outlined,
                      iconColor: customColors.grayIcon,
                      onTap: () async {
                        showButtonSheet(
                            context: context,
                            widget: const TotalWidget(),
                            height: 250);
                      },
                    ),
                  ],
                ),
                Text(
                  "200.000 sp",
                  style: customTextStyle.displaySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IMAGE extends StatelessWidget {
  const IMAGE({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: const Color(0xFFDBE2E7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Align(
                alignment: const AlignmentDirectional(0.00, 0.00),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: ExpandedImageView(
                          image: Image.asset(
                            'assets/images/events-management.jpg',
                            fit: BoxFit.contain,
                            alignment: const Alignment(0.00, 1.00),
                          ),
                          allowRotation: false,
                          tag: 'imageTag',
                          useHeroAnimation: true,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'imageTag',
                    transitionOnUserGestures: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/events-management.jpg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        alignment: const Alignment(0.00, 1.00),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingInfo extends StatelessWidget {
  const BookingInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "3 Tickets",
          style: customTextStyle.displaySmall.override(
            fontFamily: 'Nunito',
            fontSize: 20,
            useGoogleFonts: true,
          ),
        ),
        SizedBox(
          height: 30,
          child: VerticalDivider(
            thickness: 1,
            color: customColors.secondary,
          ),
        ),
        Text(
          "Nov 19 , 2023",
          style: customTextStyle.displaySmall.override(
            fontFamily: 'Nunito',
            fontSize: 20,
            useGoogleFonts: true,
          ),
        ),
        SizedBox(
          height: 30,
          child: VerticalDivider(
            thickness: 1,
            color: customColors.secondary,
          ),
        ),
        Text(
          "20:00 PM",
          style: customTextStyle.displaySmall.override(
            fontFamily: 'Nunito',
            fontSize: 20,
            useGoogleFonts: true,
          ),
        ),
      ],
    );
  }
}
