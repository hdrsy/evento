import 'package:evento/core/responsive/size_config.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../core/utils/theme/app_fonts_from_google.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../../controller/book_now_controller.dart';
import 'fill_ticket_bottom_sheet.dart';
import 'full_ticket_field.dart';
import '../../../events/event_detailes/model/event_detailes_model.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class FullTicketInfo extends StatelessWidget {
  FullTicketInfo({super.key, required this.index});
  final BookNowController bookNowController = Get.find();
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
          child: Text(
            "Ticket ${index + 1}",
            style: customTextStyle.bodyMedium.override(
              fontFamily: primaryFontFamily,
              color: customColors.primaryText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              useGoogleFonts: true,
            ),
          ),
        ),
        GetBuilder<BookNowController>(builder: (ccontext) {
          return Container(
            width: double.infinity,
            padding: padding(8, 8, 8, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: customColors.primaryBackground,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          bookNowController.removeTicket(index);
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          color: customColors.primaryText,
                          size: 20,
                        ))
                  ],
                ),
                bookNowController.eventDetailsModel.classes.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("class"),
                            style: customTextStyle.bodyMedium.override(
                                fontFamily: primaryFontFamily, fontSize: 14),
                          ),
                          Wrap(
                            children: [
                              ...List.generate(
                                  bookNowController
                                      .eventDetailsModel.classes.length,
                                  (index) => _buildRadioOption(bookNowController
                                      .eventDetailsModel.classes[index]))
                            ],
                          ),
                          bookNowController.ticketList[index].selectedClass ==
                                  null
                              ? const SizedBox.shrink()
                              : bookNowController.ticketList[index]
                                      .selectedClass!.interests.isEmpty
                                  ? const SizedBox.shrink()
                                  : Text(tr("Select Addional options"),
                                      style: customTextStyle.bodyMedium
                                          .override(
                                              fontFamily: primaryFontFamily,
                                              fontSize: 14)),
                          bookNowController.ticketList[index].selectedClass ==
                                  null
                              ? const SizedBox.shrink()
                              : Wrap(
                                  spacing: 8.0, // gap between adjacent chips
                                  runSpacing: 4.0, // gap between lines
                                  children: bookNowController.ticketList[index]
                                      .selectedClass!.interests
                                      .map((label) {
                                    return ChoiceChip(
                                      showCheckmark: false,
                                      label: Text("+ ${label.title}"),
                                      selected: bookNowController
                                          .ticketList[index].selectedAminiteds
                                          .contains(label),
                                      selectedColor: customColors.primary,
                                      onSelected: (bool selected) {
                                        bookNowController
                                            .addOrRemoveAminitesFromCladd(
                                                label, index);
                                      },
                                    );
                                  }).toList(),
                                ),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tr("Personal Information"),
                        style: customTextStyle.bodyMedium.override(
                            fontFamily: primaryFontFamily,
                            fontSize: SizeConfig.safeBlockHorizontal * 4)),
                    GestureDetector(
                      onTap: () {
                        showButtonSheet(
                            context: context,
                            widget: FilldataWidget(ticketIndex: index),
                            height: screenHeight * 0.2);
                      },
                      child: Text(tr("Fill profile / Friend list data"),
                          style: customTextStyle.bodyMedium.override(
                              fontFamily: primaryFontFamily,
                              fontSize: SizeConfig.safeBlockHorizontal * 2.5,
                              color: customColors.primary)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child: buildTextField(
                            controller:
                                bookNowController.ticketList[index].fisrtName,
                            hint: "",
                            label: tr("First Name"),
                            validator: (value) {
                              return null;
                            })),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: buildTextField(
                            controller:
                                bookNowController.ticketList[index].lastName,
                            hint: "",
                            label: tr("Last Name"),
                            validator: (value) {
                              return null;
                            })),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: buildTextField(
                            controller: bookNowController
                                .ticketList[index].couponNumber,
                            hint: "",
                            label: tr("Coupon Code"),
                            validator: (value) {
                              return null;
                            })),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: buildTextField(
                            controller: bookNowController.ticketList[index].age,
                            hint: "",
                            label: tr("Age"),
                            validator: (value) {
                              return null;
                            })),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                buildTextField(
                    controller: bookNowController.ticketList[index].phoneNumber,
                    hint: "",
                    label: tr("Phone Number"),
                    validator: (value) {
                      return null;
                    })
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRadioOption(Class singleClass) {
    BookNowController bookNowController = Get.find();
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            activeColor: customColors.primary,
            value: singleClass.code,
            groupValue:
                bookNowController.ticketList[index].selectedClass == null
                    ? ""
                    : bookNowController.ticketList[index].selectedClass!.code,
            onChanged: (newValue) {
              bookNowController.changeSelectedCalss(singleClass, index);
            },
          ),
          Text(singleClass.code,
              style: customTextStyle.bodyMedium
                  .override(fontFamily: primaryFontFamily, fontSize: 14)),
        ],
      ),
    );
  }
}
