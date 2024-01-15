import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
class InvitedfriendsText extends StatelessWidget {
  const InvitedfriendsText({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this RichText Widget...
Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
  child: RichText(
    textScaleFactor: MediaQuery.of(context).textScaleFactor,
    text: TextSpan(
      children: [
        TextSpan(
          text:tr( "Invited friends"),
          style: GoogleFonts.getFont(
            'Rubik',
            color:customColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
        const TextSpan(
          text: "2",
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
          text: "3",
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
  ),
)
;
  }
}