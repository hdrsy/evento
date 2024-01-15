import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class TotalWidget extends StatelessWidget {
  const TotalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxHeight: 230,
        ),
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          boxShadow:const [
             BoxShadow(
              blurRadius: 7,
              color: Color(0x4D000000),
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: Divider(
                  thickness: 3,
                  color: customColors.secondary,
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1.00, -1.00),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Text(
                    "Total Amount",
                    style: customTextStyle.headlineMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.dark600,
                          useGoogleFonts: true,
                        ),
                  ).tr(),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                   "The total amount is a summary of all the items in your order minus any fees and taxes.",
                  style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        useGoogleFonts: true,
                      ),
                ).tr(),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: ButtonWidget(
                  onPressed: () async {
                    Get.back();
                    },
                  text:tr(  "Okay"),
                  options: ButtonOptions(
                    height: 40,
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: customColors.primary,
                    textStyle: customTextStyle.titleSmall.override(
                          fontFamily: 'Nunito',
                          color:customColors.info,
                          useGoogleFonts: true,
                        ),
                    elevation: 2,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
