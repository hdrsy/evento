import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class TermsAndCondisionTexts extends StatelessWidget {
  const TermsAndCondisionTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: scaleHeight(5),),
        // Generated code for this Text Widget...
        Text(
          "By joining, I agree to Tables' Terms of Use & Data Privacy Center",
          style: customTextStyle.bodyMedium.copyWith(
            fontFamily: 'Merriweather',
            color: customColors.secondaryText,
            fontSize: 10,
          ),
        ),
        // Generated code for this Row Widget...
Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Text(
        "Terms of Use"  ,
        style: customTextStyle.bodyMedium.copyWith(
              fontFamily: 'Merriweather',
              fontSize: 12,

            ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
        child: Icon(
          Icons.arrow_right_alt_outlined,
          color: customColors.secondaryText,
          size: 24,
        ),
      ),
    ],
  ),
)
,// Generated code for this Row Widget...
Row(
  mainAxisSize: MainAxisSize.max,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text(
      "Data Privacy Center" ,
      style: customTextStyle.bodyMedium.copyWith(
            fontFamily: 'Merriweather',
            fontSize: 12,

          ),
    ),
    Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
      child: Icon(
        Icons.arrow_right_alt_outlined,
        color: customColors.secondaryText,
        size: 24,
      ),
    ),
  ],
)

      ],
    );
  }
}
