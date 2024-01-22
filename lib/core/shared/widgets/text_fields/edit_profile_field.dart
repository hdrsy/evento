import '../../../utils/theme/text_theme.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditProfileField extends StatelessWidget {
   EditProfileField({super.key,
  required this.controller,
  required this.hintText,
  required this.labelText,
  required this.onChanged,
  required this.validator,
   this.suffixIcon,
   this.isPasswordSecure
  });
final String labelText;
final String hintText;
final String? Function(String?)? validator;
final Function(String)? onChanged;
final TextEditingController controller;
 IconData? suffixIcon;
bool? isPasswordSecure;
  @override
  Widget build(BuildContext context) {
    return 
Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
  child: TextFormField(
    onChanged: onChanged,
    controller: controller,
    obscureText:isPasswordSecure?? false,
    decoration: InputDecoration(
      labelText: labelText,
      // floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: customTextStyle.bodyMedium.override(
            fontFamily: 'Nunito',
            color:customColors.primary,
            useGoogleFonts: true,
          ),
          
      hintText:  hintText,
      hintStyle: customTextStyle.bodyMedium.override(
            fontFamily: 'Nunito',
            fontSize: 12,
            useGoogleFonts: true,
          ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:customColors.primaryBackground,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      filled: true,
      fillColor:customColors.secondaryBackground,
      contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 10, 10, 10),
      suffixIcon:suffixIcon!=null?  Icon(
        suffixIcon,
        color: const Color(0xFF757575),
        size: 22,
      ):null,
    ),
    style: customTextStyle.titleSmall.override(
          fontFamily: 'Nunito',
          fontSize: 12,
          useGoogleFonts: true,
        ),
    validator:validator,
  ),
)
;
  }
}