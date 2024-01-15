import '../../../../../core/utils/theme/text_theme.dart';
import '../../controller/date_time_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class NotesLabel extends StatelessWidget {
   NotesLabel({super.key});
final DateTimeController dateTimeController=Get.find();
  
  @override
  Widget build(BuildContext context) {
    return 
Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
  child: Container(
    width: 360,
    height: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: customColors.primaryBackground,
      ),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
             "Description:",
            textAlign: TextAlign.center,
            style: customTextStyle.labelLarge,
          ).tr(),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: TextFormField(
                controller: dateTimeController.description,
                // controller: _model.textController4,
                // focusNode: _model.textFieldFocusNode4,
                obscureText: false,
                decoration: InputDecoration(
                  labelText:tr( "Label here..."),
                  labelStyle:
                      customTextStyle.labelMedium.override(
                            fontFamily: 'Nunito',
                            color: customColors.secondaryText,
                            useGoogleFonts: true,
                          ),
                  hintStyle: customTextStyle.labelMedium,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      useGoogleFonts: true,
                    ),
                
                   
              ),
            ),
          ),
        ],
      ),
    ),
  ),
)
;
  }
}