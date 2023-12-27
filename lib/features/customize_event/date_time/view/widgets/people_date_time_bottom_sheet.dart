import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/widget/list_wheel/build_list_wheel_scroll/list_wheel_body.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/app_fonts_from_google.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/date_time/controller/date_time_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class PeopleDateTimeBottomSheet extends StatefulWidget {
  PeopleDateTimeBottomSheet({Key? key}) : super(key: key);
  final DateTimeController dateTimeController = Get.find();
  @override
  // ignore: library_private_types_in_public_api
  _PeopleDateTimeBottomSheetState createState() =>
      _PeopleDateTimeBottomSheetState();
}

class _PeopleDateTimeBottomSheetState extends State<PeopleDateTimeBottomSheet> {
  int activeStep = 0; // Initial step

  void _nextStep() {
    if (activeStep < 2) {
      // Assuming there are 3 steps: 0, 1, 2
      setState(() {
        activeStep++;
      });
    } else {
      if (widget.dateTimeController.date > DateTime.now() &&
          (widget.dateTimeController.adultNumber > 0 ||
              widget.dateTimeController.childrenNumber > 0) &&
          widget.dateTimeController.startTime != "00:00 Am" &&
          widget.dateTimeController.endTime != "00:00 Am") {
        widget.dateTimeController.isUserEnterDateInfo = true;
        Get.back();
      } else {
        Get.snackbar("Uncomplete data", "Please fill all the required data",
            snackPosition: SnackPosition.TOP,
            backgroundColor: customColors.primaryBackground);
      }
    }
  }

  Widget _stepContent(BuildContext) {
    Widget child;
    switch (activeStep) {
      case 0:
        child = selectPeople();
        break;
      case 1:
        child = MyCalendarWidget();
        break;
      case 2:
        child = pickTime(context); // Implement this for time selection
        break;
      default:
        child = selectPeople();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: child, // New child is passed here
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: customColors.secondaryBackground,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        stepWithDivider("People", 0, Icons.people_alt_outlined),
                        stepWithDivider(
                            "Date", 1, Icons.calendar_today_outlined),
                        stepWithDivider("Time", 2, Icons.timer_outlined),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(child: _stepContent(context)),
              ButtonWidget(
                onPressed: () async {
                  _nextStep();
                },
                text: "Next",
                options: ButtonOptions(
                  width: 150,
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: customColors.primary,
                  textStyle: customTextStyle.titleSmall.override(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                  ),
                  elevation: 3,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ].addToStart(const SizedBox(height: 24)),
          ),
        ));
  }

  Widget stepWithDivider(String stepName, int index, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() {
          activeStep = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: customColors.primaryText,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  stepName,
                  style: customTextStyle.bodyMedium.override(
                      fontFamily: primaryFontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: customColors.primaryText,
                      useGoogleFonts: true),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: index == activeStep
                      ? customColors.primary
                      : customColors.primaryBackground,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 100,
                child: Divider(
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                  color: customColors.secondaryText,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
class MyCalendarWidget extends StatefulWidget {
  final DateTimeController dateTimeController = Get.find();

  @override
  _MyCalendarWidgetState createState() => _MyCalendarWidgetState();
}

class _MyCalendarWidgetState extends State<MyCalendarWidget> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: screenHeight*0.05,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        widget.dateTimeController.date=selectedDay;
        setState(() {
          this.selectedDay = selectedDay;
          this.focusedDay = focusedDay; // update focusedDay as well if needed
        });
      },
      // ... other properties
    );
  }
}

Widget selectPeople() {
  final DateTimeController dateTimeController = Get.find();

  return Obx(
    () => Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                  child: Container(width: 70, child: const Text("Adult")),
                ),
                Material(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: customColors.secondaryBackground,
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: customColors.secondaryBackground,
                          width: 2,
                        ),
                      ),
                      child: Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                            color: customColors.primaryBackground,
                            border: Border.all(
                                width: 2,
                                color: customColors.primaryBackground),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: customColors.shadow,
                                  offset: const Offset(1, 1))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  dateTimeController.adultNumber.value > 0
                                      ? dateTimeController.adultNumber.value--
                                      : null;
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: customColors.secondaryText,
                                  size: 20,
                                )),
                            Text(
                              "${dateTimeController.adultNumber.value}",
                              style: customTextStyle.bodyMedium.override(
                                  color: customColors.primaryText,
                                  fontFamily: primaryFontFamily,
                                  fontSize: 22),
                            ),
                            IconButton(
                                onPressed: () {
                                  dateTimeController.adultNumber++;
                                },
                                icon: Icon(Icons.add,
                                    color: customColors.primary, size: 20)),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                  child: Container(width: 70, child: const Text("children")),
                ),
                Material(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: customColors.secondaryBackground,
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: customColors.secondaryBackground,
                          width: 2,
                        ),
                      ),
                      child: Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                            color: customColors.primaryBackground,
                            border: Border.all(
                                width: 2,
                                color: customColors.primaryBackground),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: customColors.shadow,
                                  offset: const Offset(1, 1))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  dateTimeController.childrenNumber.value > 0
                                      ? dateTimeController
                                          .childrenNumber.value--
                                      : null;
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: customColors.secondaryText,
                                  size: 20,
                                )),
                            Text(
                              "${dateTimeController.childrenNumber.value}",
                              style: customTextStyle.bodyMedium.override(
                                  color: customColors.primaryText,
                                  fontFamily: primaryFontFamily,
                                  fontSize: 22),
                            ),
                            IconButton(
                                onPressed: () {
                                  dateTimeController.childrenNumber.value++;
                                },
                                icon: Icon(Icons.add,
                                    color: customColors.primary, size: 20)),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget pickTime(BuildContext context) {
  final DateTimeController dateTimeController = Get.find();
  return GetBuilder<DateTimeController>(builder: (ccontext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            showButtonSheet(
                context: context,
                widget: ListWheelBody(isStartTime: true),
                height: screenHeight * 0.3);
          },
          child: Container(
            width: screenWidth * 0.35,
            padding: padding(10, 20, 10, 20),
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: customColors.alternate,
              ),
            ),
            child: Row(
              children: [
                Text(
                  "from",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: customColors.primary,
                  ),
                ),
                SizedBox(
                  width: scaleWidth(10),
                ),
                Text(
                  dateTimeController.startTime,
                  style: customTextStyle.bodySmall.override(
                    fontFamily: 'Readex Pro',
                    color: customColors.secondaryText,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 10), // Space between the input fields
        InkWell(
          onTap: () async {
            showButtonSheet(
                context: context,
                widget: ListWheelBody(isStartTime: false),
                height: screenHeight * 0.3);
          },
          child: Container(
            width: screenWidth * 0.35,
            padding: padding(10, 20, 10, 20),
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: customColors.alternate,
              ),
            ),
            child: Row(
              children: [
                Text(
                  "To",
                  style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: customColors.primary,
                  ),
                ),
                SizedBox(
                  width: scaleWidth(10),
                ),
                Text(
                  dateTimeController.endTime,
                  style: customTextStyle.bodySmall.override(
                    fontFamily: 'Readex Pro',
                    color: customColors.secondaryText,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  });
}
