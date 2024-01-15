import '../../../../main.dart';
import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  // required FocusNode focusNode,
  required String label,
  required String hint,
  required FormFieldValidator<String> validator,
}) {
  final TextStyle labelStyle = TextStyle(
    fontFamily: 'Nunito',
    color: customColors.secondaryText,
    fontSize: 12,
    // useGoogleFonts: false,
  );

  final TextStyle hintStyle = TextStyle(
    fontFamily: 'Nunito',
    color: customColors.primaryText,
    // useGoogleFonts: false,
  );

  final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      color: customColors.primaryBackground,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  return TextFormField(
    controller: controller,
    // focusNode: focusNode,
    obscureText: false,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      enabledBorder: borderStyle,
      focusedBorder: borderStyle,
      errorBorder: borderStyle,
      focusedErrorBorder: borderStyle,
      filled: true,
      fillColor: customColors.secondaryBackground,
      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
    ),
    style: hintStyle,
    validator: validator,
  );
}
