import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';


class TextFieldContactInformation extends StatelessWidget {
  final String labelKey;
  final String hintTextKey;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? validator;

  const TextFieldContactInformation({super.key, 
    required this.labelKey,
    required this.hintTextKey,
    required this.controller,
    required this.focusNode,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          labelKey,
          style: customTextStyle.bodyMedium.override(
                fontFamily: 'Nunito',
                color: customColors.secondaryText,
                fontSize: 12,
                useGoogleFonts: false,
              ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: hintTextKey,
                labelStyle:customTextStyle.labelMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.secondaryText,
                      useGoogleFonts: true,
                    ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.primary,
                    useGoogleFonts: true,
                  ),
              validator: (value){
                return validator;
                },
            ),
          ),
        ),
      

Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
  child: Icon(
    Icons.edit_outlined,
    color: customColors.secondaryText,
    size: 24,
  ),
)

      ],
    );
  }
}
