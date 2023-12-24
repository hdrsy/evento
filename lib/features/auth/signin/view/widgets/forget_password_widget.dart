import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class FogetPasswordWidget extends StatelessWidget {
  const FogetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this RichText Widget...
        InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        // context.pushNamed('Forgetpassword');
      },
      child: RichText(
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Forget Password?",
              style: customTextStyle.bodyMedium.copyWith(
                fontFamily: 'Merriweather',
                color: customColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: " send me code.",
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
