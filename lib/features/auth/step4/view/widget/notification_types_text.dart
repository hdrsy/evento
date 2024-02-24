import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationTypesText extends StatelessWidget {
  const NotificationTypesText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(48, 0, 48, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF4B39EF),
                  shape: BoxShape.circle,
                ),
                alignment: const AlignmentDirectional(0.00, 0.00),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Text(
                  "New weekly reminder",
                  style: customTextStyle.bodyMedium.copyWith(
                    fontFamily: 'BeerSerif',
                    fontWeight: FontWeight.normal,
                  ),
                ).tr(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4B39EF),
                    shape: BoxShape.circle,
                  ),
                  alignment: const AlignmentDirectional(0.00, 0.00),
                  child: const Icon(
                    Icons.spa,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Text(
                    "Events reminder",
                    style: customTextStyle.bodyMedium.copyWith(
                      fontFamily: 'BeerSerif',
                      fontWeight: FontWeight.normal,
                    ),
                  ).tr(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4B39EF),
                    shape: BoxShape.circle,
                  ),
                  alignment: const AlignmentDirectional(0.00, 0.00),
                  child: const Icon(
                    Icons.personal_video_outlined,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Text(
                    "Personalised program",
                    style: customTextStyle.bodyMedium.copyWith(
                      fontFamily: 'BeerSerif',
                      fontWeight: FontWeight.normal,
                    ),
                  ).tr(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
