
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_choice_chips.dart';
import 'package:evento/core/utils/helper/flutter_flow_drop_down.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/helper/form_field_controller.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterWidget extends StatelessWidget {
   FilterWidget({Key? key}) : super(key: key);

  FormFieldController<String>? dropDownValueController;

  FormFieldController<List<String>>? choiceChipsValueController;

  List<String>? choiceChipsValues;

  @override
  Widget build(BuildContext context) {
    

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        boxShadow:const [
           BoxShadow(
            blurRadius: 6,
            color: Color(0x35000000),
            offset: Offset(0, -2),
          )
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
        child: SingleChildScrollView(
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
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 4),
                  child: Text(
                    "Filter",
                    style: customTextStyle.headlineSmall,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.00, -1.00),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.00, -1.00),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: Text(
                            "Event Catergory",
                            style: customTextStyle
                                .bodyMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  color: customColors.primaryText,
                                  useGoogleFonts: true,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0.00, 0.00),
                            child: FlutterFlowChoiceChips(
                              options:const [
                                ChipData("All"),
                                ChipData(
                                    "Music",
                                    Icons.music_note_rounded),
                                ChipData(
                                     "Workshops",
                                    Icons.work),
                                ChipData(
                                    "Art",
                                    Icons.color_lens_sharp),
                                ChipData(
                                     "Food & Drink",
                                    Icons.fastfood_rounded),
                                ChipData(
                                     "Fashion",
                                    Icons.linked_camera)
                              ],
                              onChanged: (val) {}
                                  ,
                              selectedChipStyle: ChipStyle(
                                backgroundColor:
                                    customColors.primary,
                                textStyle: customTextStyle
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: customColors
                                          .secondaryBackground,
                                      useGoogleFonts: true,
                                    ),
                                iconColor: customColors.tertiary,
                                iconSize: 18,
                                elevation: 0,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: const Color(0x00000000),
                                textStyle: customTextStyle 
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: customColors
                                          .secondaryText,
                                      useGoogleFonts: true,
                                    ),
                                iconColor:
                                    customColors.secondaryText,
                                iconSize: 18,
                                elevation: 0,
                                borderColor: customColors
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              chipSpacing: 12,
                              rowSpacing: 12,
                              multiselect: true,
                              initialized: choiceChipsValues != null,
                              alignment: WrapAlignment.start,
                              controller: choiceChipsValueController ??=
                                  FormFieldController<List<String>>(
                                [],
                              ),
                              wrapped: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                color: customColors.secondary,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                    child: Text(
                      "Location",
                      style: customTextStyle.bodyMedium.override(
                            fontFamily: 'Nunito',
                            color: customColors.primaryText,
                            useGoogleFonts: true,
                          ),
                    ),
                  ),
                  FlutterFlowDropDown<String>(
                    controller: dropDownValueController ??=
                        FormFieldController<String>(null),
                    options:const  [
                       "Damascus",
                      "Tartus",
                      "Homs",
                       "Lattakia" 
                    ],
                    onChanged: (val){},
                    width: 200,
                    height: 40,
                    textStyle: customTextStyle.bodyMedium,
                    hintText: "Please select...",
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: customColors.secondaryText,
                      size: 24,
                    ),
                    fillColor: customColors.secondaryBackground,
                    elevation: 2,
                    borderColor: customColors.primaryBackground,
                    borderWidth: 2,
                    borderRadius: 8,
                    margin: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                    hidesUnderline: true,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                ].divide(const SizedBox(width: 10)),
              ),
              Divider(
                thickness: 2,
                color: customColors.secondary,
              ),
              Align(
                alignment: const AlignmentDirectional(-1.00, -1.00),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Text(
                    "Ticket Price Range",
                    style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.primaryText,
                          useGoogleFonts: true,
                        ),
                  ),
                ),
              ),
              SliderTheme(
                data: const SliderThemeData(
                  showValueIndicator: ShowValueIndicator.always,
                ),
                child: Slider(
                  activeColor: customColors.primary,
                  inactiveColor: customColors.secondaryBackground,
                  min: 1,
                  max: 20,
                  value: 2,
                  label: "2",
                  onChanged: (newValue) {
                    // newValue = double.parse(newValue.toStringAsFixed(20));
                    // setState(() => _model.sliderValue1 = newValue);
                  },
                ),
              ),
              Divider(
                thickness: 2,
                color: customColors.secondary,
              ),
              Align(
                alignment: const AlignmentDirectional(-1.00, -1.00),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Text(
                    "Event Location Range (km)",
                    style: customTextStyle.bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: customColors.primaryText,
                          useGoogleFonts: true,
                        ),
                  ),
                ),
              ),
              SliderTheme(
                data: const SliderThemeData(
                  showValueIndicator: ShowValueIndicator.always,
                ),
                child: Slider(
                  activeColor: customColors.primary,
                  inactiveColor: customColors.secondaryBackground,
                  min: 1,
                  max: 20,
                  value:1,
                  label:"1",
                  onChanged: (newValue) {
                    // newValue = double.parse(newValue.toStringAsFixed(20));
                    // setState(() => _model.sliderValue2 = newValue);
                  },
                ),
              ),
              Divider(
                thickness: 2,
                color: customColors.secondary,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        onPressed: () {
                          },
                        text: "Reset",
                        options: ButtonOptions(
                          width: 120,
                          height: 35,
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: customColors.secondaryBackground,
                          textStyle: customTextStyle
                              .titleSmall
                              .override(
                                fontFamily: 'Nunito',
                                color: customColors.primaryText,
                                fontSize: 12,
                                useGoogleFonts: false,
                              ),
                          borderSide: BorderSide(
                            color: customColors.primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      ButtonWidget(
                        onPressed: () async {
                          // Navigator.pop(context);
                        },
                        text: "Apply filters",
                        options: ButtonOptions(
                          width: 120,
                          height: 35,
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: customColors.primary,
                          textStyle:
                              customTextStyle.titleSmall.override(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    fontSize: 12,
                                    useGoogleFonts: false,
                                  ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
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
