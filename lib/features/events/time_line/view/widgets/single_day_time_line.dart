import '../../../../../core/utils/helper/styled_vertical_divider.dart';
import '../../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../model/single_day_time_line_model.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:timelines/timelines.dart';

class SingleDayTimeLine extends StatelessWidget {
  final SingleDayTimeLineModel singleDayTimeLineModel;

  SingleDayTimeLine({Key? key, required this.singleDayTimeLineModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ExpandableNotifier(
        controller: ExpandableController(initialExpanded: true),
        child: ExpandablePanel(
            collapsed: Container(
              decoration: BoxDecoration(
                color: customColors.secondaryBackground,
              ),
            ),
            header: Row(
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1.00, -1.00),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(43, 5, 10, 5),
                    child: Icon(
                      Icons.radio_button_checked_outlined,
                      color: customColors.primary,
                      size: 24,
                    ),
                  ),
                ),
                Text(
                  "Day-${singleDayTimeLineModel.dayName}",
                  style: customTextStyle.displaySmall.override(
                    fontFamily: breeSerif,
                    color: customColors.primaryText,
                    fontSize: 20,
                    useGoogleFonts: false,
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
              iconColor: customColors.primaryText,
            ),
            expanded: Container(
              alignment: Alignment.center,
              // height: 500,
              child: FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                  nodePosition: 0.15,
                  color: const Color(0xff989898),
                  connectorTheme: const ConnectorThemeData(
                    thickness: 2.5,
                  ),
                ),
                builder: TimelineTileBuilder.connectedFromStyle(
                  contentsAlign: ContentsAlign.basic,
                  oppositeContentsBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      singleDayTimeLineModel.dayTrips.keys.elementAt(index),
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: breeSerif,
                        color: customColors.primaryText,
                        fontSize: 14,
                        useGoogleFonts: false,
                      ),
                    ),
                  ),
                  contentsBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      singleDayTimeLineModel.dayTrips.values.elementAt(index),
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: breeSerif,
                        color: customColors.primaryText,
                        useGoogleFonts: false,
                      ),
                    ),
                  ),
                  lastConnectorStyle: ConnectorStyle.dashedLine,
                  firstConnectorStyle: ConnectorStyle.dashedLine,
                  connectorStyleBuilder: (context, index) =>
                      ConnectorStyle.dashedLine,
                  indicatorStyleBuilder: (context, index) =>
                      IndicatorStyle.outlined,
                  itemCount: singleDayTimeLineModel.dayTrips.length,
                ),
              ),
            )),
      ),
    );
  }
}

class HourWithDesc extends StatelessWidget {
  const HourWithDesc(
      {super.key, required this.description, required this.hour});
  final String hour;
  final String description;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      // Use IntrinsicHeight to ensure the Row children take up full height
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Stretch children vertically
          children: [
            HourWidget(hour: hour),
            const SizedBox(
              width: 4,
            ),
            StyledVerticalDivider(
              thickness: 3,
              color: customColors.secondaryText,
              lineStyle: DividerLineStyle.dotted,
            ),
            Expanded(
              child: Description(description: description),
            ),
          ],
        ),
      ),
    );
  }
}

class HourWidget extends StatelessWidget {
  const HourWidget({super.key, required this.hour});
  final String hour;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        hour,
        style: customTextStyle.bodyMedium.override(
          fontFamily: breeSerif,
          color: customColors.primaryText,
          useGoogleFonts: true,
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 200,
      child: Text(
        description,
        style: customTextStyle.bodyMedium.override(
          fontFamily: breeSerif,
          color: customColors.primaryText,
          useGoogleFonts: false,
        ),
      ),
    );
  }
}
