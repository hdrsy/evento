import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/buttons/icon_with_container.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../../controller/book_now_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class PriceSummaryWidget extends StatelessWidget {
  PriceSummaryWidget({super.key, required this.index});
  final int index;
  final BookNowController bookNowController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookNowController>(builder: (context) {
      return Container(
          padding: padding(8, 8, 8, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: customColors.primaryBackground,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ticket ${index + 1}",
                      style: customTextStyle.displaySmall.override(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        useGoogleFonts: true,
                      ),
                    ),
                  ],
                ),
              ),
              priceElement(
                  "Ticket", bookNowController.eventDetailsModel.ticketPrice),
              bookNowController.ticketList[index].selectedClass == null
                  ? SizedBox.shrink()
                  : priceElement(
                      bookNowController.ticketList[index].selectedClass!.code,
                      bookNowController
                          .ticketList[index].selectedClass!.ticketPrice),
              ...List.generate(
                  bookNowController.ticketList[index].selectedAminiteds.length,
                  (innerIndex) => priceElement(
                      bookNowController.ticketList[index]
                          .selectedAminiteds[innerIndex].title,
                      bookNowController.ticketList[index]
                          .selectedAminiteds[innerIndex].pivot.price!)),
              // priceElement("Taxes", bookNowController.ticketList[index].tax),
              priceElement(
                  "Discount", bookNowController.ticketList[index].discount),
              Divider(
                thickness: 1,
                indent: 12,
                endIndent: 12,
                color: customColors.secondary,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Total",
                          style: customTextStyle.headlineSmall.override(
                            fontFamily: 'Lexend Deca',
                            color: const Color(0xFF8B97A2),
                            fontSize: 20,
                            useGoogleFonts: true,
                            fontWeight: FontWeight.normal,
                          ),
                        ).tr(),
                        IconWithContainer(
                          borderRadius: 30,
                          backgroundColor: customColors.secondaryBackground,
                          buttonSize: 36,
                          icon: Icons.info_outlined,
                          iconColor: customColors.grayIcon,
                          onTap: () async {
                            // await showModalBottomSheet(
                            //   isScrollControlled: true,
                            //   backgroundColor: Colors.transparent,
                            //   barrierColor: Color(0xB3000000),
                            //   context: context,
                            //   builder: (context) {
                            //     return Padding(
                            //       padding: MediaQuery.viewInsetsOf(context),
                            //       child: Container(
                            //         height: 270,
                            //         child: TotalWidget(),
                            //       ),
                            //     );
                            //   },
                            // ).then((value) => safeSetState(() {}));
                          },
                        ),
                      ],
                    ),
                    Text(
                      "${bookNowController.ticketList[index].totalPrice} ${tr("sp")}",
                      style: customTextStyle.displaySmall,
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }

  Padding priceElement(String title, price) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: customTextStyle.bodySmall.override(
                fontFamily: 'Lexend Deca',
                color: const Color(0xFF8B97A2),
                fontSize: 14,
                fontWeight: FontWeight.normal,
                useGoogleFonts: true),
          ).tr(),
          Text(
            "$price ${tr("sp")}",
            style: customTextStyle.bodyLarge.override(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              useGoogleFonts: true,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
