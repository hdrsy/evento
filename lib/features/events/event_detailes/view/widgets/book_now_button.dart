import 'package:evento/core/shared/widgets/guest/guest_popup.dart';

import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../booking/book_now/controller/book_now_controller.dart';
import '../../../../booking/book_now/view/book_now_screen.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class BookNowButton extends StatelessWidget {
  const BookNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ButtonWidget(
        onPressed: () async {
          if (isGuset) {
            Get.dialog(const GuestPopupWidget());
          } else {
            await showButtonSheet(
                context: context,
                widget: BookNowScreen(),
                height: MediaQuery.sizeOf(context).height * 0.9);
            Get.delete<BookNowController>();
          }
        },
        text: tr("Book Now"),
        options: ButtonOptions(
          width: 230,

          height: 45,

          // padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),

          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),

          color: customColors.primary,

          textStyle: customTextStyle.titleSmall.override(
            fontFamily: 'Lexend Deca',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),

          elevation: 3,

          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),

          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
