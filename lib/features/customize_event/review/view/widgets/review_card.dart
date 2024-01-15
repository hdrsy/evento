import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import 'left_text_widget.dart';
import 'right_text_widget.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key,required this.leftColumnData,required this.rightColumnData,required this.title});
final String title;
final List<String> leftColumnData;
final List<String> rightColumnData ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 11,),
        headline(title),
        Container(
            width: double.infinity,
            padding: padding(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: customColors.primaryBackground,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    leftColumn(leftColumnData),
                    rightColumn(rightColumnData),
                  ],
                ),
              ],
            ))
      ].divide(const SizedBox(
        height: 10,
      )),
    );
  }

  Column rightColumn(List<String > rightColumnData) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ...List.generate(rightColumnData.length, (index) => RightTextWidget(value: rightColumnData[index])),
       
      ].divide(const SizedBox(height: 5)),
    );
  }

  Column leftColumn(List<String> leftColumnData) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(rightColumnData.length, (index) => LeftTextWidget(title: leftColumnData[index])),
       
      ].divide(const SizedBox(height: 5)),
    );
  }

  Row headline(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: customTextStyle.headlineMedium.override(
              fontSize: 22, fontWeight: FontWeight.w500, fontFamily: "Nunito"),
        ),
        Align(
          alignment: const AlignmentDirectional(1.00, -1.00),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
            child: Icon(
              Icons.edit_outlined,
              color: customColors.primary,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
