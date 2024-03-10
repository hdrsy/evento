import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
import 'notification_service.dart'; // Adjust this import path to where your NotificationService class is located.

class WorkmanagerService {
  static void initializeWorkmanager() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true, // Remember to set this to false in production
    );

    // Registering the periodic task
    Workmanager().registerPeriodicTask(
        "uniqueName_fetchNotifications", // Unique task name for fetching notifications
        "fetchNotifications", // Task name that the background task checks for
        frequency:
            Duration(minutes: 15), // Minimum frequency allowed is 15 minutes
        constraints: Constraints(
          networkType: NetworkType.connected,
        ));
    print("object");
  }

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      print("the task is :$task");
      switch (task) {
        case "fetchNotifications":
          print("testtt");
          await fetchNotifications();
          break;
        default:
          print("Task not found");
      }
      return Future.value(true); // Indicate success or failure
    });
  }

  static Future<void> fetchNotifications() async {
    print("start fetch notification");
    try {
      Either<ErrorResponse, Map<String, dynamic>> response;
      String token = await prefService.readString("token");
      response = await ApiHelper.makeRequest(
          targetRout: ServerConstApis.getNotification,
          method: "GEt",
          token: token);
      dynamic handlingResponse = response.fold((l) => l, (r) => r);
      print(handlingResponse);
      if (handlingResponse is ErrorResponse) {
      } else {
        whenGetDataSuccess(handlingResponse);
      }
    } catch (e) {
      print("Error fetching notifications: $e");
    }
  }
}

whenGetDataSuccess(handlingResponse) {
  List<dynamic> categoryListJson = handlingResponse['Notification'];

  for (var i = 0; i < categoryListJson.length; i++) {
    NotificationService().showNotification(
        i, categoryListJson[i]['title'], categoryListJson[i]['description']);
  }
}
// Ensure to call WorkmanagerService.initializeWorkmanager() at the appropriate place in your app, typically within the main function.
