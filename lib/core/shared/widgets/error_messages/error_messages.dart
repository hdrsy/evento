import 'package:easy_localization/easy_localization.dart';

import '../../../../main.dart';
import 'package:flutter/material.dart';

class ErrorMessages extends StatelessWidget {
  const ErrorMessages({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.error, color: customColors.error),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style:
                customTextStyle.bodyMedium.copyWith(color: customColors.error),
          ).tr(),
        ),
      ],
    );
  }
}
