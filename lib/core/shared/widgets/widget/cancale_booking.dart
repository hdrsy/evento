import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/widget/confirm_cancale_booking.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/booking/my_booking/controller/cancel_booking_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelBookingWidget extends StatelessWidget {
  CancelBookingWidget({Key? key}) : super(key: key);
  final CancelBookingController cancelBookingController =
      Get.put(CancelBookingController());

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
      child: SingleChildScrollView(
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
                    "Please select the reason for cancellation",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      useGoogleFonts: true,
                    ),
                  ).tr(),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioButtonList(titles: [
                        tr("I have another event"),
                        tr("I'm sick,  can't come"),
                        tr("I have an urgent need"),
                        tr("I have no transportation to come"),
                        tr("I want to book another event"),
                        tr("I just want to cancel")
                      ]),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Text(
                          "Other",
                          style: customTextStyle.bodyMedium,
                        ).tr(),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: TextFormField(
                          onChanged: (value) {
                            cancelBookingController.selectedValue = value;
                            cancelBookingController.update();
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: customTextStyle.labelMedium,
                            hintText: tr("Others reason"),
                            hintStyle: customTextStyle.labelMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.secondaryText,
                              useGoogleFonts: true,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: customColors.primaryBackground,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: customColors.primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: customColors.error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: customColors.error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: customTextStyle.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ]
                    .divide(const SizedBox(height: 20))
                    .addToStart(const SizedBox(height: 20)),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
              child: ButtonWidget(
                onPressed: () async {
                  Get.back();
                  if (cancelBookingController.selectedValue != null &&
                      cancelBookingController.selectedValue!.length > 4) {
                    showButtonSheet(
                        context: context,
                        widget: ConfirmCancelBookingWidget(),
                        height: 200);
                  } else {
                    Get.snackbar("Action Required",
                        "Please select a reason for cancellation from the list or type in your specific reason to proceed with booking cancellation.",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: customColors.primaryBackground);
                  }
                },
                text: tr("Cancel Booking"),
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
      ),
    );
  }
}

class RadioButtonList extends StatefulWidget {
  final List<String> titles;
  const RadioButtonList({Key? key, required this.titles}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RadioButtonListState createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...List.generate(
          widget.titles.length,
          (index) => GetBuilder<CancelBookingController>(
                  builder: (cancelBookingController) {
                return RadioListTile<String>(
                  activeColor: customColors.primary,
                  title: Text(
                    widget.titles[index],
                    style: _selectedValue != widget.titles[index]
                        ? customTextStyle.bodyMedium.override(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            useGoogleFonts: true,
                          )
                        : customTextStyle.titleMedium,
                  ),
                  value: widget.titles[index],
                  groupValue: cancelBookingController.selectedValue,
                  contentPadding: EdgeInsets
                      .zero, // Removes default padding around the tile content
                  dense: true,
                  onChanged: (String? value) {
                    setState(() {});
                    cancelBookingController.selectedValue = value;
                    cancelBookingController.update();
                  },
                );
              }))
    ]);
  }
}
