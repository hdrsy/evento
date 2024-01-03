import 'package:evento/core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/book_now/controller/book_now_controller.dart';
import 'package:evento/features/book_now/view/book_now_screen.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookNowButton extends StatelessWidget {
  const BookNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return 
        Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ButtonWidget(
        onPressed: () async {
        await  showButtonSheet(context: context, widget: BookNowScreen(), height: MediaQuery.sizeOf(context).height * 0.9);
          Get.delete<BookNowController>();
                             
          },
        text: "Book Now",
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
