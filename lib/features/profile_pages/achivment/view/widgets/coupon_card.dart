// Import necessary Flutter packages and your custom theme.
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/features/profile_pages/achivment/model/coupon_model.dart';
import 'package:evento/features/profile_pages/achivment/view/widgets/show_coupon_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

// Define a StatelessWidget named 'CouponCard'.
class CouponCard extends StatelessWidget {
  // Define required fields for the widget.

  final PromoCode promoCode;
  // Constructor for the CouponCard, initializing with required values.
  const CouponCard({Key? key, required this.promoCode}) : super(key: key);

  // Override the build method to describe how the UI should be constructed.
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        InkWell(
          onTap: () {
            // Add your onTap functionality here
            showButtonSheet(
                context: context,
                widget: CouponsWidget(promoCode: promoCode),
                height: screenHeight * 0.5);
          },
          child: Container(
            width: 350,
            height: 150,
            decoration: BoxDecoration(
              // Use your custom theme for styling.
              color: customColors.secondaryBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: customColors.primaryBackground,
              ),
            ),
            child: Row(
              children: [
                // Container for the offer text.
                Container(
                  width: 55,
                  decoration: BoxDecoration(
                    color: randomColor(),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "OFFER",
                        style: customTextStyle.bodyMedium.copyWith(
                          color: customColors.info,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                // Expanded section for coupon details.
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Row for the image and title.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Display the coupon image.
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: getImageNetwork(
                                    url: promoCode.image,
                                    width: 62,
                                    height: 62)),
                            // Display the coupon title.
                            Text(
                              "${promoCode.discount}% ${tr("Off")}",
                              style: customTextStyle.bodyMedium.copyWith(
                                color: customColors.primaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // Display the coupon subtitle.
                        Text(
                          promoCode.description,
                          style: customTextStyle.bodyMedium.copyWith(
                            color: customColors.primaryText,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                        // Row for displaying expiry details.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Expires at',
                              style: customTextStyle.bodyMedium,
                            ).tr(),
                            Text(
                              DateFormatter.formatDate(promoCode.endDate),
                              style: customTextStyle.bodyMedium.copyWith(
                                color: customColors.primaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Additional design elements - circles at the bottom corners.
        Align(
          alignment: const AlignmentDirectional(-1, 1),
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(1, 1),
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
              shape: BoxShape.circle,
            ),
          ),
        ),
        theCouponCurve(true),
        theCouponCurve(false)
      ],
    );
  }

  Positioned theCouponCurve(bool isFromRight) {
    return Positioned(
      top: 65,
      left: isFromRight ? null : -12,
      right: isFromRight ? -12 : null,
      child: Container(
        width: 50,
        height: 20.0, // Height of the container
        decoration: BoxDecoration(
          color: customColors.secondaryBackground, // Use the custom color
          shape: BoxShape.circle, // Makes the container circular
        ),
      ),
    );
  }
}

Color? randomColor() {
  List<Color?> colors = [
    const Color(
        0x33000000), // Assuming this is a valid color code in your context
    Colors.amber[800],
    Colors.green,
    const Color(
        0xFF7D40E7) // Assuming 'purply' is a purple color, represented here in hex format
  ];

  return colors[Random().nextInt(colors.length)];
}
