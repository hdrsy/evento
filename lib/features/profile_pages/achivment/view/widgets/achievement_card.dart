import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final String offerReason;
  final String couponInfo;
  final int hwoMany;
  final int hwoManyIsDone;

  const AchievementCard({
    Key? key,
    required this.title,
    required this.offerReason,
    required this.couponInfo,
    required this.hwoMany,
    required this.hwoManyIsDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        boxShadow: const [
          BoxShadow(
              blurRadius: 4, color: Color(0x33000000), offset: Offset(0, 2))
        ],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: customColors.primaryBackground),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextSection(context),
            generateProgressesIndicators(hwoMany, hwoManyIsDone)
          ],
        ),
      ),
    );
  }

  Widget generateProgressesIndicators(int hwoMany, int hwoManyDone) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      ...List.generate(hwoMany, (index) {
        if (index < hwoManyDone) {
          return _buildProgressIndicators(true, hwoMany);
        } else {
          return _buildProgressIndicators(false, hwoMany);
        }
      }),
    ]);
  }

  Widget _buildTextSection(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: customTextStyle.bodyMedium.copyWith(
            fontFamily: 'Readex Pro',
            color: customColors.primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          offerReason,
          style: customTextStyle.bodyMedium.copyWith(
            fontFamily: 'Readex Pro',
            color: customColors.secondaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        RichText(
          // textScaler: MediaQuery.of(context).textScaler,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Coupons: '.tr(),
                style: customTextStyle.bodyMedium.copyWith(
                  fontFamily: 'Readex Pro',
                  color: customColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: couponInfo,
                style: customTextStyle.bodyMedium.copyWith(
                  fontFamily: 'Readex Pro',
                  color: customColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            style: customTextStyle.bodyMedium,
          ),
        ),
      ].divide(SizedBox(height: 5,)),
    );
  }

  Widget _buildProgressIndicators(bool isDone, int hwoMany) {
    return LinearPercentIndicator(
      percent: isDone ? 1 : 0,
      width: (screenWidth * .8) / hwoMany,
      lineHeight: 10,
      animation: true,
      animateFromLastPercent: true,
      progressColor: customColors.primary,
      backgroundColor: customColors.primaryBackground,
      barRadius: const Radius.circular(20),
      padding: EdgeInsets.zero,
    );
  }
}
