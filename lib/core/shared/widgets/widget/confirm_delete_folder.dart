import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDeleteConfirmation(BuildContext context, Function() deleteFolder) {
  Get.dialog(
    AlertDialog(
      title: Text('Delete Folder'),
      content: Text('Are you sure you want to delete this folder?'),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Get.back(); // Close the dialog
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            // Call your method to delete the folder here
            deleteFolder();
            Get.back(); // Close the dialog
          },
        ),
      ],
    ),
    barrierDismissible: false, // User must tap a button to close the dialog
  );
}
