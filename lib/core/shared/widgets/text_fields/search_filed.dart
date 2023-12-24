import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

Widget searchTextField(
    {
      required Function(String?)? onChanged,
    }) {
  return Container(
  // width: 300,
  height: 45,
  decoration: BoxDecoration(
    color: customColors.primaryBackground,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
          child: Icon(
            Icons.search_rounded,
            color: Color(0xFF8B9BA8),
            size: 24,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
            child: TextFormField(
              // controller: _model.textController,
              // focusNode: _model.textFieldFocusNode,
              onChanged: onChanged,
              obscureText: false,
              decoration: InputDecoration(
                hintText:  "Search...",
                hintStyle:customTextStyle.bodyMedium.override(
                    fontFamily: 'Open Sans',
                    color: customColors.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ) ,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Open Sans',
                    color: customColors.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
              // validator: _model.textControllerValidator.asValidator(context),
            ),
          ),
        ),
      ],
    ),
  ),
)
;
}
