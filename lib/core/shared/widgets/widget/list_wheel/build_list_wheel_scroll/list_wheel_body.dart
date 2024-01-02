import 'dart:developer';

import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/widget/list_wheel/build_list_wheel_scroll/am_pm.dart';
import 'package:evento/core/shared/widgets/widget/list_wheel/build_list_wheel_scroll/build_buttons.dart';
import 'package:evento/core/shared/widgets/widget/list_wheel/build_list_wheel_scroll/hours.dart';
import 'package:evento/core/shared/widgets/widget/list_wheel/build_list_wheel_scroll/minutes.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/customize_event/date_time/controller/date_time_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ListWheelBody extends StatefulWidget {
  const ListWheelBody({super.key,required this.isStartTime });
  
final bool isStartTime;
  @override
  State<ListWheelBody> createState() => _ListWheelBodyState();
}

class _ListWheelBodyState extends State<ListWheelBody> {
  late FixedExtentScrollController _hoursController;
  late FixedExtentScrollController _minutesController;
  late FixedExtentScrollController _ampmController;

  @override
  void initState() {
    super.initState();
    int initHour = DateTime.now().hour;
    int initMinutes = DateTime.now().minute;
    int initAmPm = 0;
    if (initHour >= 12) {
      initAmPm = 1;
    }
    if (initHour > 12) {
      initHour -= 12;
    }
    _hoursController = FixedExtentScrollController(initialItem: initHour);
    _minutesController = FixedExtentScrollController(initialItem: initMinutes);
    _ampmController = FixedExtentScrollController(initialItem: initAmPm);
  }

  @override
  void dispose() {
    // Dispose of all controllers
    _hoursController.dispose();
    _minutesController.dispose();
    _ampmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight = 50; // This is your itemExtent

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
              height: scaleHeight(200),
              child: build_body_wheels(itemHeight, context)),
              buildButtons(context: context,onPressedSubmit: () {
           final DateTimeController dateTimeController=Get.find();
            // String selectedTime =
            //       "${_hoursController.selectedItem + 1}:${_minutesController.selectedItem} ${_ampmController.selectedItem==0?"Am":"Pm"} ";
            int selectedHour = _hoursController.selectedItem + 1; // Hours are 1-12
int selectedMinute = _minutesController.selectedItem; // Minutes are 0-59
bool isAm = _ampmController.selectedItem == 0;
DateTime now = DateTime.now();
DateTime selectedDateTime = DateTime(now.year, now.month, now.day, selectedHour, selectedMinute);

if (!isAm && selectedHour != 12) { // PM and not 12 PM
  selectedHour += 12;
} else if (isAm && selectedHour == 12) { // 12 AM
  selectedHour = 0;
}

              if (widget.isStartTime) {
                dateTimeController.startTime = selectedDateTime;
              } else {
                dateTimeController.endTime = selectedDateTime;
              }
              dateTimeController.update();
              Get.back();
         },)
         ],
         
      ),
    );
  }

  Stack build_body_wheels(double itemHeight, BuildContext context) {
    return Stack(
      children: [
        Align(
          // top: centralItemTopOffset,
          alignment: Alignment.center,

          child: Container(
            height: scaleHeight(itemHeight),
            margin: padding(20, 20, 20, 20),
            // width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(scaleWidth(20))),
              color: customColors.secondaryText,
            ),
          ),
        ),

        buildWheelsHoursMinuetsAmPm(),
        // Positioned overlay with a transparent window
      ],
    );
  }

  Row buildWheelsHoursMinuetsAmPm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // hours wheel
        SizedBox(
          width: scaleWidth(70),
          child: ListWheelScrollView.useDelegate(
            controller: _hoursController,
            itemExtent: 50,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() {});
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 12,
              builder: (context, index) {
                final bool isCenterItem =
                    index == _hoursController.selectedItem;
                return MyHours(
                  isCenterItem: isCenterItem,
                  hours: index + 1,
                );
              },
            ),
          ),
        ),

        // minutes wheel
        SizedBox(
          width: scaleWidth(70),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            perspective: 0.005,
            diameterRatio: 1.2,
            controller: _minutesController,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              
              setState(() {});
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 60,
              builder: (context, index) {
                final bool isCenterItem =
                    index == _minutesController.selectedItem;

                return MyMinutes(
                  isCenterItem: isCenterItem,
                  mins: index,
                );
              },
            ),
          ),
        ),

        // am or pm
        SizedBox(
          width: scaleWidth(70),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            controller: _ampmController,
            onSelectedItemChanged: (index) {
              
              setState(() {});
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 2,
              builder: (context, index) {
                final bool isCenterItem = index == _ampmController.selectedItem;

                if (index == 0) {
                  return AmPm(
                    isCenterItem: isCenterItem,
                    isItAm: true,
                  );
                } else {
                  return AmPm(
                    isCenterItem: isCenterItem,
                    isItAm: false,
                  );
                }
              },
            ),
          ),
        ),
      ].divide(SizedBox(
        width: scaleWidth(0),
      )),
    );
  }
}
