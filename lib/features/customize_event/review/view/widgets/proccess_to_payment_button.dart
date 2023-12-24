import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class ProccessToPaymentButton extends StatelessWidget {
  const ProccessToPaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Button Widget...
ButtonWidget(
  onPressed: () async {
    // context.pushNamed('Payment');
  },
  text: "Proceed to Payment",
  options: ButtonOptions(
    height: 40,
    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    color: customColors.primary,
    textStyle: customTextStyle.titleSmall,
    elevation: 3,
    borderSide: const BorderSide(
      color: Colors.transparent,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
)
;
  }
}