import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/achivment/model/coupon_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

class CouponsWidget extends StatelessWidget {
  const CouponsWidget({Key? key, required this.promoCode}) : super(key: key);
  final PromoCode promoCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: Container(
                width: 350,
                height: 340,
                decoration: BoxDecoration(
                  color: customColors.primaryBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                color: customColors.alternate,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              alignment: const AlignmentDirectional(0, 0),
                              child: Text(
                                "OFFER",
                                textAlign: TextAlign.start,
                                style: customTextStyle.bodyMedium.override(
                                  fontFamily: 'Nunito',
                                  color: customColors.info,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: false,
                                ),
                              ).tr(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 16, 16, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      promoCode.title,
                                      style:
                                          customTextStyle.bodyMedium.override(
                                        fontFamily: 'Nunito',
                                        color: customColors.primaryText,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts: false,
                                      ),
                                    ),
                                    Text(
                                      promoCode.description,
                                      style: customTextStyle.bodyMedium,
                                      maxLines: 3,
                                    ),
                                    // Text(
                                    //    "-Applicable for all types of events – concerts, seminars, workshops, and more.",
                                    //   style: customTextStyle
                                    //       .bodyMedium,
                                    // ),
                                  ].divide(const SizedBox(height: 10)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(),
                                      child: BarcodeWidget(
                                        data: 'Barcode',
                                        barcode: Barcode.qrCode(),
                                        width: 100,
                                        height: 90,
                                        color: customColors.primaryText,
                                        backgroundColor: Colors.transparent,
                                        errorBuilder: (_context, _error) =>
                                            const SizedBox(
                                          width: 100,
                                          height: 90,
                                        ),
                                        drawText: false,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Expires",
                                              style: customTextStyle.bodyMedium,
                                            ),
                                            Text(
                                              DateFormatter.formatDate(
                                                  promoCode.endDate),
                                              style: customTextStyle.bodyMedium
                                                  .override(
                                                fontFamily: 'Nunito',
                                                color: customColors.primaryText,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                            ),
                                          ].divide(const SizedBox(height: 5)),
                                        ),
                                        // ButtonWidget(
                                        //   onPressed: () {},
                                        //   text: "Redeem",
                                        //   options: ButtonOptions(
                                        //     width: 120,
                                        //     height: 40,
                                        //     padding: const EdgeInsetsDirectional
                                        //         .fromSTEB(24, 0, 24, 0),
                                        //     iconPadding:
                                        //         const EdgeInsetsDirectional
                                        //             .fromSTEB(0, 0, 0, 0),
                                        //     color: customColors.primary,
                                        //     textStyle: customTextStyle
                                        //         .titleSmall
                                        //         .override(
                                        //       fontFamily: 'Nunito',
                                        //       color: Colors.white,
                                        //       fontSize: 14,
                                        //       fontWeight: FontWeight.w500,
                                        //       useGoogleFonts: false,
                                        //     ),
                                        //     elevation: 3,
                                        //     borderSide: const BorderSide(
                                        //       color: Colors.transparent,
                                        //       width: 1,
                                        //     ),
                                        //     borderRadius:
                                        //         BorderRadius.circular(20),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ].divide(const SizedBox(height: 10)),
                                ),
                              ].divide(const SizedBox(height: 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
              .addToStart(const SizedBox(height: 16))
              .addToEnd(const SizedBox(height: 16)),
        ),
      ),
    );
  }
}
