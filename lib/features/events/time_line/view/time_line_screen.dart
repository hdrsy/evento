import '../controller/time_line_controller.dart';
import 'widgets/header.dart';
import 'widgets/single_day_time_line.dart';
import 'widgets/time_line_main_image.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TimeLineScreen extends StatelessWidget {
  TimeLineScreen({super.key});

  TimeLineController timeLineController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              TimeLineMainImage(
                imgUrl:
                    "/storage/${timeLineController.eventDetailsModel.images[0]}",
              ),
              const SizedBox(
                height: 20,
              ),

              buildHeaderTimeLine(context),
              // ..._buildTimelineEvents(context),
              ...List.generate(
                  timeLineController.eventTrip.length,
                  (index) => SingleDayTimeLine(
                        singleDayTimeLineModel:
                            timeLineController.eventTrip[index],
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
