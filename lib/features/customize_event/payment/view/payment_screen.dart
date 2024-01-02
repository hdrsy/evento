import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/customize_event/payment/controller/payment_controller.dart';
import 'package:evento/features/customize_event/payment/view/widget/slider5.dart';
import 'package:evento/features/customize_event/payment/view/widget/step_text5.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  final PaymentController paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text("Payment",
              style: customTextStyle.bodyMedium
                  .copyWith(color: customColors.primary, fontSize: 20)),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: customColors.primaryText,
              size: 30,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: padding(16, 24, 16, 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StepText5(),
                const LinearPercentIndicatorWidget5(),
              ].divide(SizedBox(
                height: scaleHeight(10),
              ))),
        ));
  }
}
