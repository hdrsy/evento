import 'package:evento/core/shared/widgets/error_messages/error_messages.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../core/shared/widgets/images/network_image.dart';
import '../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../controller/book_now_controller.dart';
import 'widgets/full_ticket_info.dart';
import 'widgets/price_summary_widget.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class BookNowScreen extends StatelessWidget {
  BookNowScreen({super.key});
  final BookNowController bookNowController = Get.put(BookNowController());

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
      child: Obx(
        () => Form(
          key: bookNowController.formstate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: Divider(
                  thickness: 3,
                  color: customColors.secondary,
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                controller: bookNowController.scrollController,
                padding: padding(0, 24, 0, 24),
                child: Column(
                  children: [
                    image(context),
                    EventName(
                      /////name
                      eventName: bookNowController.eventDetailsModel.title,
                    ),
                    EventLocation(
                      ///// show location
                      eventLocation:
                          bookNowController.eventDetailsModel.venue.governorate,
                    ),
                    Divider(
                      height: 2,
                      thickness: 1,
                      color: customColors.secondary,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // const TicketCount(),
                    ...List.generate(
                        bookNowController.ticketList.length,
                        (index) => TicketCard(
                              index: index,
                            )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            BookNowController bookNowController = Get.find();
                            bookNowController.addnewTicket();
                          },
                          child: Text(
                            tr("Add Ticket"),
                            style: customTextStyle.bodyMedium.override(
                                fontFamily: primaryFontFamily,
                                useGoogleFonts: true,
                                fontSize: 14,
                                color: customColors.primary),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    // const PaymontInformation(),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: ButtonWidget(
                        showLoadingIndicator: bookNowController.isLoading.value,
                        onPressed: () async {
                          bookNowController.ticketList.isNotEmpty
                              ? bookNowController.onPressBookNow()
                              : null;
                        },
                        text: tr("Confirm Booking"),
                        options: ButtonOptions(
                          width: 300,
                          height: 40,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              32, 0, 32, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: bookNowController.ticketList.isNotEmpty
                              ? customColors.primary
                              : customColors.alternate,
                          textStyle: customTextStyle.displaySmall.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: 0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    ...List.generate(
                        bookNowController.errorMessage.length,
                        (index) => ErrorMessages(
                              message: bookNowController.errorMessage[index],
                            )),
                  ].addToEnd(SizedBox(
                    height: 15.h,
                  )),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Padding image(BuildContext context) {
    final BookNowController bookNowController = Get.find();
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: getImageNetwork(
              url: "/storage/${bookNowController.eventDetailsModel.images[0]}",
              width: screenWidth * 0.9,
              height: 120)),
    );
  }
}

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: customColors.secondaryBackground,
      child: Column(
        children: [
          FullTicketInfo(index: index),
          PriceSummaryWidget(
            index: index,
          ),
        ],
      ),
    );
  }
}

class EventLocation extends StatelessWidget {
  const EventLocation({super.key, required this.eventLocation});
  final String eventLocation;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              eventLocation,
              style: customTextStyle.bodySmall.override(
                  fontFamily: 'Lexend Deca',
                  color: const Color(0xFF8B97A2),
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  useGoogleFonts: true),
            ),
          ),
        ],
      ),
    );
  }
}

class EventName extends StatelessWidget {
  const EventName({super.key, required this.eventName});
  final String eventName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              eventName,
              style: customTextStyle.displaySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20, // Circle diameter
      height: 20, // Circle diameter
      decoration: BoxDecoration(
        color: customColors.primaryBackground,
        shape: BoxShape.circle,
      ),
    );
  }
}
