import 'package:evento/core/const/states.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_choice_chips.dart';
import 'package:evento/core/utils/helper/flutter_flow_drop_down.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/helper/form_field_controller.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/home/controller/home_controller.dart';
import 'package:evento/features/events/home/model/category_model.dart';
import 'package:evento/features/search/controller/search_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

// ignore: must_be_immutable
class FilterWidget extends StatefulWidget {
  FilterWidget({Key? key, required this.onApplyFilters}) : super(key: key);
  final Function(Map<String, dynamic>) onApplyFilters;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;

  FormFieldController<String>? dropDownValueController;

  FormFieldController<List<String>>? choiceChipsValueController;
  double locationRange = 1;
  double _valueSlider = 400000;
  List<String>? choiceChipsValues;
  CategoryListController categoryListController = Get.find();
  List<CategoryModel> categoryList = [];
  double sliderValuePricerangeStart = 0.0;
  double sliderValuePricerangeEnd = 2000000.0;

// = categoryListController.categoryList
  @override
  Widget build(BuildContext context) {
    categoryList.assignAll(categoryListController.categoryList);
    categoryList.removeAt(0);
    categoryList.removeAt(0);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        boxShadow: const [
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
                  ).tr(),
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
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: Text(
                            "Event Catergory",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              useGoogleFonts: true,
                            ),
                          ).tr(),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0.00, 0.00),
                            child: FlutterFlowChoiceChips(
                              options: [
                                ...List.generate(
                                    categoryList.length,
                                    (index) =>
                                        ChipData(categoryList[index].title))
                              ],
                              onChanged: (val) {},
                              selectedChipStyle: ChipStyle(
                                backgroundColor: customColors.primary,
                                textStyle: customTextStyle.bodyMedium.override(
                                  fontFamily: 'Nunito',
                                  color: customColors.secondaryBackground,
                                  useGoogleFonts: true,
                                ),
                                iconColor: customColors.tertiary,
                                iconSize: 18,
                                elevation: 0,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: const Color(0x00000000),
                                textStyle: customTextStyle.bodyMedium.override(
                                  fontFamily: 'Nunito',
                                  color: customColors.secondaryText,
                                  useGoogleFonts: true,
                                ),
                                iconColor: customColors.secondaryText,
                                iconSize: 18,
                                elevation: 0,
                                borderColor: customColors.primaryBackground,
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
                    ).tr(),
                  ),
                  FlutterFlowDropDown<String>(
                    controller: dropDownValueController ??=
                        FormFieldController<String>(null),
                    options: states,
                    onChanged: (val) {
                      setState(() {
                        dropDownValueController!.value = val;
                      });
                    },
                    width: 200,
                    height: 40,
                    textStyle: customTextStyle.bodyMedium,
                    hintText: tr("Please select..."),
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
                  ).tr(),
                ),
              ),
              _buildPriceRangeSlider(),
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
                  ).tr(),
                ),
              ),
              SfSlider(
                min: 1000,
                max: 400000,
                stepSize: 1000,
                value: _valueSlider,
                showDividers: false,
                showTicks: false,
                showLabels: false, // Set to false to hide static labels
                enableTooltip: true,
                labelPlacement: LabelPlacement.betweenTicks,
                minorTicksPerInterval: 2,
                activeColor: customColors.primary,
                inactiveColor: customColors.secondaryText,

                tooltipTextFormatterCallback:
                    (dynamic actualValue, String formattedText) {
                  // Customizing the tooltip text to show "km" unit
                  int kmValue = (actualValue / 1000).toInt();
                  return "$kmValue km";
                },
                onChanged: (dynamic newValue) {
                  setState(() {
                    _valueSlider = newValue;
                  });
                },
              ),
              Divider(
                thickness: 2,
                color: customColors.secondary,
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        onPressed: () {
                          // Resetting all filter values to their defaults
                          setState(() {
                            // Resetting the choice chips to null or an empty list if multiselect is true
                            choiceChipsValueController?.value = [];
                            // Resetting the dropdown value to null
                            dropDownValueController?.value = null;
                            // Resetting the slider values to their default values
                            _valueSlider = 1000;
                            // Resetting any other fields you have to their default values
                            locationRange =
                                1; // Example for resetting a simple slider
                          });
                        },
                        text: tr("Reset"),
                        options: ButtonOptions(
                          width: 120,
                          height: 35,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: customColors.secondaryBackground,
                          textStyle: customTextStyle.titleSmall.override(
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
                        showLoadingIndicator: isLoading,
                        onPressed: () async {
                          if (!isLoading) {
                            // Prevent multiple taps
                            setState(() {
                              isLoading = true; // Show loading indicator
                            });
                          }
                          // Navigator.pop(context);
                          Map<String, dynamic> data = {};
                          if (choiceChipsValueController != null) {
                            List<String> selectedChoices = [];
                            selectedChoices
                                .assignAll(choiceChipsValueController!.value!);
                            if (selectedChoices.contains('All')) {
                              selectedChoices.clear();
                              selectedChoices
                                  .assignAll(categoryList.map((e) => e.title));
                            }
                            List<int> selectedIds = [];
                            selectedIds = categoryList
                                .where((category) =>
                                    selectedChoices.contains(category.title))
                                .map((category) => category.id)
                                .toList();
                            data["event_category"] = selectedIds;
                          }
                          if (dropDownValueController != null) {
                            data['state'] = dropDownValueController!.value;
                          }
                          data['min_ticket_price'] =
                              sliderValuePricerangeStart > 1000000
                                  ? getPriceNumberToShow(
                                      sliderValuePricerangeStart)
                                  : sliderValuePricerangeStart;
                          data['max_ticket_price'] = sliderValuePricerangeEnd >
                                  1000000
                              ? getPriceNumberToShow(sliderValuePricerangeEnd)
                              : sliderValuePricerangeEnd;
                          data['distance'] = _valueSlider;
                          data['latitude'] = userLocation.latitude;
                          data['longitude'] = userLocation.longitude;
                          if (data.isNotEmpty) {
                            await widget.onApplyFilters(data);
                          }
                          if (mounted) {
                            setState(() {
                              isLoading = false; // Hide loading indicator
                            });
                          }
                        },
                        text: tr("Apply filters"),
                        options: ButtonOptions(
                          width: 120,
                          height: 35,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: customColors.primary,
                          textStyle: customTextStyle.titleSmall.override(
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

  Widget _buildPriceRangeSlider() {
    double min = 0;
    double max = 2000000;
    double firstDivisionMax = 1000000;
    return RangeSlider(
      min: min,
      max: max,
      values: RangeValues(sliderValuePricerangeStart, sliderValuePricerangeEnd),
      onChanged: (RangeValues values) {
        setState(() {
          sliderValuePricerangeStart = values.start;
          sliderValuePricerangeEnd = values.end;
        });
      },
      labels: priceLabels(firstDivisionMax),
      divisions: 100,
      activeColor: customColors.primary,
      inactiveColor: customColors.secondaryBackground,
    );
  }

  RangeLabels priceLabels(double firstDivisionMax) {
    return RangeLabels(
      sliderValuePricerangeStart >= firstDivisionMax
          ? '${((getPriceNumberToShow(sliderValuePricerangeStart) ~/ 1000000)).toString()} m ${tr('SP')}'
          : '${(sliderValuePricerangeStart).toString()} ${tr('SP')}',
      sliderValuePricerangeEnd >= firstDivisionMax
          ? '${((getPriceNumberToShow(sliderValuePricerangeEnd) ~/ 1000000)).toString()} m ${tr('SP')}'
          : '${(sliderValuePricerangeEnd).toString()} ${tr('SP')}',
    );
  }

  double getPriceNumberToShow(double numberBetweenOneAndTwoMillion) {
    return 4 * numberBetweenOneAndTwoMillion - 3000000;
  }
}
