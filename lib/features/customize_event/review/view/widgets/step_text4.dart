import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepText4 extends StatelessWidget {
  const StepText4({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this RichText Widget...
RichText(
  textScaleFactor: MediaQuery.of(context).textScaleFactor,
  text: TextSpan(
    children: [
      TextSpan(
        text:  "STEP",
        style: GoogleFonts.getFont(
          'Rubik',
          color: const Color(0xFF4B39EF),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      const TextSpan(
        text:  "4",
        style: TextStyle(
          color: Color(0xFF4B39EF),
        ),
      ),
      const TextSpan(
        text:  "/",
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
)
;
  }
}