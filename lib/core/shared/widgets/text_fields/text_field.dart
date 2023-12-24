import 'package:evento/main.dart';
import 'package:flutter/material.dart';

Widget customTextField(
    {Widget? prefix,
    required BuildContext context,
    required String label,
    bool? isPassWordVisible,
    Widget? suffixIcon,
    String? errorText,
    required String? Function(String?) validator,
    required Function(String?)? onChanged,
    TextInputType? keyboardType
    }) {
  return TextFormField(
    // onSaved: onChanged,
    onChanged: onChanged,
    keyboardType: keyboardType,
    // controller: _model.firstNameController1,
    obscureText: isPassWordVisible??false,
    decoration: InputDecoration(
      
      hoverColor: customColors.secondaryBackground,
      suffixIcon:suffixIcon,
      prefix: prefix,
      errorText: errorText,
      labelText: label,
      labelStyle: customTextStyle.bodyMedium.copyWith(
            fontFamily: 'Merriweather',
            color: customColors.secondaryText,
            fontSize: 12,
            
          ),
      hintStyle: customTextStyle.bodyMedium.copyWith(
        fontFamily: 'Merriweather',
        color: customColors.secondaryText,
        fontWeight: FontWeight.w400,
        fontSize: 12
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: customColors.primaryBackground,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(
          color: customColors.primaryBackground,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:  BorderSide(
          color: customColors.error,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:  BorderSide(
          color: customColors.error,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      filled: true,
      fillColor: customColors.primaryBackground,
      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
    ),
    style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontFamily: 'Merriweather',
          color: customColors.secondaryText,
        ),
    validator: validator,
  );
}
