import '../../event_detailes/model/event_detailes_model.dart';
import '../model/single_day_time_line_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeLineController extends GetxController {
  late EventDetailsModel eventDetailsModel;
  late List<SingleDayTimeLineModel> eventTrip;
  int bookingNumber = 0;
  @override
  void onInit() {
    eventDetailsModel = Get.arguments;
    eventTrip = generateTimeLine(eventDetailsModel.eventTrips);
    bookingNumber = eventDetailsModel.bookings.length;
    super.onInit();
  }

  List<SingleDayTimeLineModel> generateTimeLine(List<EventTrip> trips) {
    Map<String, Map<String, String>> groupedTrips = {};

    for (var trip in trips) {
      String dayKey = DateFormat('yyyy-MM-dd').format(trip.startDate);

      if (!groupedTrips.containsKey(dayKey)) {
        groupedTrips[dayKey] = {};
      }

      // Format the start time of the trip for the key
      String startTime = DateFormat('HH:mm').format(trip.startDate);
      groupedTrips[dayKey]![startTime] = trip.description;
    }

    // Convert the grouped trips into a list of SingleDayTimeLineModel
    return groupedTrips.entries.map((entry) {
      return SingleDayTimeLineModel(dayName: entry.key, dayTrips: entry.value);
    }).toList();
  }
}
