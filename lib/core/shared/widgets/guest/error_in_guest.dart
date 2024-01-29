import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorInGuest extends StatelessWidget {
  const ErrorInGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      body: SizedBox(
        child: Center(
          child: GestureDetector(
              onTap: () {
                Get.offAllNamed('/');
              },
              child: Text("You are guest")),
        ),
      ),
    );
  }
}
