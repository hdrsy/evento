import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/responsive/responsive.dart';
import '../../../../../main.dart';
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
          "By sign in, I agree to Evento'...",
          style: customTextStyle.bodyMedium.copyWith(
            fontFamily: 'Merriweather',
            color: customColors.secondaryText,
            fontSize: 10,
          ),
        ).tr(),
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
      ).tr(),
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
// Row(
//   mainAxisSize: MainAxisSize.max,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Text(
//       "Data Privacy Center" ,
//       style: customTextStyle.bodyMedium.copyWith(
//             fontFamily: 'Merriweather',
//             fontSize: 12,

//           ),
//     ).tr(),
//     Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
//       child: Icon(
//         Icons.arrow_right_alt_outlined,
//         color: customColors.secondaryText,
//         size: 24,
//       ),
//     ),
//   ],
// )

      ],
    );
  }
}
