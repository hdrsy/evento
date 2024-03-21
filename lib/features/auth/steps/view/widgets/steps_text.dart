import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class StepsText extends StatelessWidget {
  StepsText({super.key, required this.pageIdex});
  int pageIdex;
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
          TextSpan(
            text: "$pageIdex",
            style: const TextStyle(
              color: Color(0xFF4B39EF),
            ),
          ),
          const TextSpan(
            text: " /",
            style: TextStyle(
              color: Color(0xFF4B39EF),
            ),
          ),
          const TextSpan(
            text: "7",
            style: TextStyle(
              color: Color(0xFF4B39EF),
            ),
          )
        ],
        style: customTextStyle.bodyMedium.copyWith(
          fontFamily: 'BeerSerif',
          color: const Color(0xFF4B39EF),
          letterSpacing: 1,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
