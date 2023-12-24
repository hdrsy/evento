import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/book_now/view/widgets/full_ticket_field.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

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
        ),
        buildTextField(
            controller: TextEditingController(),
            hint: "1234567",
            label: "Card Number",
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
                    label: "Exp.Date",
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
                    label: "CVV",
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
