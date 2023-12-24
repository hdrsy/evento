import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class EventTypesWidget extends StatelessWidget {
  const EventTypesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
          child: Align(
            alignment: const AlignmentDirectional(-1.00, -1.00),
            child: Text(
               "Choose type to set your event",
              style: customTextStyle.bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: customColors.secondaryText,
                    fontSize: 14,
                    useGoogleFonts: false,
                  ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
          child: Wrap(
            spacing: scaleWidth(50),
            runSpacing: scaleHeight(16),
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              ...List.generate(15, (index) => const IconContainerWidget(
                iconData: Icons.wc_rounded,
                textLabelKey:  "Wedding",
              ),)
              
              
            ],
          ),
        ),
      ],
    );
  }
}
class IconContainerWidget extends StatelessWidget {
  final IconData iconData;
  final String textLabelKey;

  const IconContainerWidget({super.key, required this.iconData, required this.textLabelKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: customColors.primaryBackground,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: customColors.secondaryText,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            textLabelKey,
            style: customTextStyle.bodyMedium,
          ),
        ),
      ],
    );
  }
}
