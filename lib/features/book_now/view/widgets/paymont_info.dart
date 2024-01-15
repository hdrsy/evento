import '../../../../core/utils/helper/flutter_flow_util.dart';
import 'full_ticket_field.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymontInformation extends StatelessWidget {
  const PaymontInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Information ",
          style: customTextStyle.bodyMedium,
        ).tr(),
        buildTextField(
            controller: TextEditingController(),
            hint: "1234567",
            label:tr( "Card Number"),
            validator: (value) {
              return null;
            }),
        Row(
          children: [
            Expanded(
                // flex: 4,
                child: buildTextField(
                    controller: TextEditingController(),
                    hint: "12/23",
                    label:tr( "Exp.Date"),
                    validator: (value) {
                      return null;
                    })),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: buildTextField(
                    controller: TextEditingController(),
                    hint: "123",
                    label:tr( "CVV"),
                    validator: (value) {
                      return null;
                    })),
          ],
        ),
      ].divide(const SizedBox(
        height: 5,
      )),
    );
  }
}
