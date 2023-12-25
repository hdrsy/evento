import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/core/utils/helper/flutter_flow_choice_chips.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/helper/form_field_controller.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: padding(16,16,0,16),
        child: Column(
          children: [
            const ChipsC(),
            searchTextField(onChanged: (value){}),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    question(context, "What is evento?",
                        "Lorem ipsum dolor sit amet, co..ddddddddddddddddddddddddddddddddddddddddddddddddddddddddd."),
                    question(context, " How to make a payment?",
                        "Lorem ipsum dolor sit amet, co..."),
                    question(context, " How do I can cancel booking?",
                        "Lorem ipsum dolor sit amet, co..."),
                    question(context, " How to change the app language",
                        "Lorem ipsum dolor sit amet, co..."),
                    question(context, "How do change my password? ",
                        "Lorem ipsum dolor sit amet, co..."),
                  ].divide(const SizedBox(height: 20)),
                ),
              ),
            )
          ].divide(const SizedBox(height: 16,)),
        ),
      ),
    );
  }

  Row question(BuildContext context, String question, String answer) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: customColors.primaryBackground,
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Container(
                width: double.infinity,
                color: const Color(0x00000000),
                child: ExpandableNotifier(
                  controller: ExpandableController(initialExpanded: false),
                  child: ExpandablePanel(
                    header: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1.00, -1.00),
                          child: Text(
                            question,
                            style: customTextStyle.displaySmall.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    collapsed: Container(
                      width: MediaQuery.sizeOf(context).width * 0,
                      height: 0,
                      decoration: const BoxDecoration(),
                    ),
                    expanded: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Divider(
                          thickness: 1,
                          color: customColors.secondary,
                        ),
                        Text(
                          answer,
                          style: customTextStyle.bodyMedium.override(
                            fontFamily: 'Nunito',
                            color: customColors.secondaryText,
                            useGoogleFonts: true,
                          ),
                        ),
                      ],
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                      iconColor: customColors.secondaryText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class ChipsC extends StatefulWidget {
  const ChipsC({super.key});

  @override
  State<ChipsC> createState() => _ChipsCState();
}

class _ChipsCState extends State<ChipsC> {
  // ignore: prefer_typing_uninitialized_variables
  var choiceChipsValue;
  FormFieldController<List<String>>? choiceChipsValueController;
  @override
  Widget build(BuildContext context) {
    return 
Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
  child: FlutterFlowChoiceChips(
    options: const [
      ChipData("General"),
      ChipData("Account"),
      ChipData( "Service"),
      ChipData("Payment")
    ],
    onChanged: (val) => setState(() => choiceChipsValue = val?.first),
    selectedChipStyle: ChipStyle(
      backgroundColor:customColors.primary,
      textStyle:customTextStyle.bodyMedium.override(
            fontFamily: 'Nunito',
            color:customColors.info,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            useGoogleFonts: true,
          ),
      iconColor: const Color(0x00000000),
      iconSize: 18,
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
    ),
    unselectedChipStyle: ChipStyle(
      backgroundColor: const Color(0x00000000),
      textStyle: customTextStyle.bodyMedium.override(
            fontFamily: 'Nunito',
            color:customColors.primary,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            useGoogleFonts: true,
          ),
      iconColor:customColors.secondaryText,
      iconSize: 18,
      elevation: 0,
      borderColor:customColors.primary,
      borderRadius: BorderRadius.circular(16),
    ),
    chipSpacing: 12,
    rowSpacing: 12,
    multiselect: false,
    alignment: WrapAlignment.start,
    controller: choiceChipsValueController ??=
        FormFieldController<List<String>>(
      [],
    ),
    wrapped: true,
  ),
)
;
  }
}