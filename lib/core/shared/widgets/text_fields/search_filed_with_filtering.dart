import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/toggle_icon.dart';
import 'package:evento/core/shared/widgets/widget/filter_widget.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class SearchFieldWithFiltering extends StatelessWidget {
  const SearchFieldWithFiltering({super.key});

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
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Search...",
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
                          widget: FilterWidget(),
                          height: 450);
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
