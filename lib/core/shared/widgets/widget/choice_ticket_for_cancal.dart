import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/widget/cancale_booking.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/booking/my_booking/controller/cancel_booking_controller.dart';
import 'package:evento/features/booking/my_booking/model/up_coming_booking.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class ChoiceTicketForCancalWidget extends StatelessWidget {
  ChoiceTicketForCancalWidget({Key? key, required this.bookings})
      : super(key: key);
  final List<Booking> bookings;
  final CancelBookingController cancelBookingController =
      Get.put(CancelBookingController());
  @override
  Widget build(BuildContext context) {
    cancelBookingController.bookings = [];
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            child: Divider(
              thickness: 3,
              color: customColors.secondary,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please select the Tickets for cancellation",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    useGoogleFonts: true,
                  ),
                ).tr(),
                SizedBox(
                    height: screenHeight * 0.45,
                    child: RadioButtonList(
                      bookings: bookings,
                    )),
              ]
                  .divide(const SizedBox(height: 20))
                  .addToStart(const SizedBox(height: 20)),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
            child: ButtonWidget(
              onPressed: () async {
                Get.back();
                showButtonSheet(
                    context: context,
                    widget: CancelBookingWidget(),
                    height: screenHeight * 0.7);
              },
              text: tr("Continue"),
              options: ButtonOptions(
                height: 40,
                padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
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
          ),
        ].divide(const SizedBox(height: 8)),
      ),
    );
  }
}

class RadioButtonList extends StatefulWidget {
  final List<Booking> bookings;
  const RadioButtonList({Key? key, required this.bookings}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RadioButtonListState createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ...List.generate(
            widget.bookings.length,
            (index) => ddd(
                  eventBooking: widget.bookings[index],
                  index: index,
                ))
      ]),
    );
  }
}

class ddd extends StatelessWidget {
  const ddd({super.key, required this.eventBooking, required this.index});
  final Booking eventBooking;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelBookingController>(
      builder: (c) => GestureDetector(
        onTap: () async {
          // context.pushNamed('Account-privacy');
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    unselectedWidgetColor: customColors.secondaryText,
                  ),
                  child: Checkbox(
                    value: c.selectedTicket.contains(eventBooking.id),
                    onChanged: (value) {
                      c.changeSelected(eventBooking.id);
                    },
                    activeColor: customColors.primary,
                    checkColor: customColors.info,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Ticket ${index + 1} : ${eventBooking.firstName} ${eventBooking.lastName}",
//                    ,
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primaryText,
                    fontSize: 16,
                    useGoogleFonts: true,
                  ),
                ),
              ].divide(const SizedBox(width: 5)),
            ),
          ],
        ),
      ),
    );
  }
}
