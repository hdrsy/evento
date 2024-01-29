import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';

import '../bottom_sheets/show_bottom_sheet.dart';
import '../buttons/toggle_icon.dart';
import '../widget/filter_widget.dart';
import '../../../utils/theme/text_theme.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';

class SearchFieldWithFiltering extends StatelessWidget {
  SearchFieldWithFiltering(
      {super.key,
      this.onChanged,
      this.controller,
      required this.onApplyFilters});
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Function(Map<String, dynamic>) onApplyFilters;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: customColors.primaryBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
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
                        controller: controller,
                        onChanged: onChanged,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: tr("Search..."),
                          hintStyle: customTextStyle.bodyMedium.override(
                              fontFamily: 'Open Sans',
                              color: customColors.secondaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: true),
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
                            useGoogleFonts: true),
                      ),
                    ),
                  ),
                  ToggleIcon(
                    onPressed: () async {
                      await showButtonSheet(
                          context: context,
                          widget: FilterWidget(onApplyFilters: onApplyFilters),
                          height: screenHeight * 0.6);
                    },
                    value: false,
                    onIcon: Icon(
                      Icons.filter_list_off,
                      color: customColors.primary,
                      size: 25,
                    ),
                    offIcon: Icon(
                      Icons.filter_list,
                      color: customColors.primary,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
