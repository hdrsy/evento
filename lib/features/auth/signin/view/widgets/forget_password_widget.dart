import 'package:easy_localization/easy_localization.dart';

import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FogetPasswordWidget extends StatelessWidget {
  const FogetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // context.pushNamed('Forgetpassword');
        Get.toNamed('/EnterNumberScreen');
      },
      child: RichText(
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        text: TextSpan(
          children: [
            TextSpan(
              text: tr("Forget Password?"),
              style: customTextStyle.bodyMedium.copyWith(
                fontFamily: 'Merriweather',
                color: customColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: tr(" send me code."),
              style: TextStyle(
                color: customColors.secondaryText,
                fontSize: 12,
              ),
            )
          ],
          style: customTextStyle.bodyMedium,
        ),
      ),
    );
  }
}
