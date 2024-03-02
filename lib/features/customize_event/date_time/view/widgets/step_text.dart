import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class StepText2 extends StatelessWidget {
  const StepText2({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this RichText Widget...
        RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: tr("STEP"),
            style: GoogleFonts.getFont(
              'Rubik',
              color: const Color(0xFF4B39EF),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const TextSpan(
            text: "3",
            style: TextStyle(
              color: Color(0xFF4B39EF),
            ),
          ),
          const TextSpan(
            text: "/",
            style: TextStyle(
              color: Color(0xFF4B39EF),
            ),
          ),
          const TextSpan(
            text: "5",
            style: TextStyle(
              color: Color(0xFF4B39EF),
            ),
          )
        ],
        style: customTextStyle.bodyMedium.override(
          fontFamily: 'Nunito',
          color: const Color(0xFF4B39EF),
          letterSpacing: 1,
          fontWeight: FontWeight.w500,
          useGoogleFonts: true,
        ),
      ),
    );
  }
}
