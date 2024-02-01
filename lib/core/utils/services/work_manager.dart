import 'package:evento/core/utils/services/socket_servie.dart';
import 'package:evento/core/utils/services/user_info.dart';
import 'package:evento/main.dart';
import 'package:workmanager/workmanager.dart';

void registertask() {
  Workmanager().registerPeriodicTask(
    '1', "notificationSystem",
    frequency: Duration(hours: 1), // frequency of task execution
    // initialDelay: Duration(seconds: 5), // delay before the first execution
    constraints: Constraints(
        networkType:
            NetworkType.connected, // only run when connected to the network,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false),
  );
}