import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../core/utils/theme/text_theme.dart';
import '../../controller/book_now_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class TicketCount extends StatelessWidget {
  const TicketCount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BookNowController bookNowController=Get.find();
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Numberr of tickets",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.primary,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: true,
                      ),
                    ).tr(),
                  ].divide(const SizedBox(height: 5)),
                ),
                Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            bookNowController.deCrementTicketCount();
                          },
                          child: Icon(
                            Icons.do_disturb_on_outlined,
                            color: customColors.secondaryText,
                            size: 18,
                          ),
                        ),
                        Obx(
                          ()=> Text(
                           bookNowController.ticketList.length.toString() ,
                            style: customTextStyle.titleLarge,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            // bookNowController.inCrementTicketCount();
                          },
                          child: Icon(
                            Icons.add_circle_outline,
                            color: customColors.primary,
                            size: 18,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            height: 2,
            thickness: 1,
            color: customColors.secondary,
          ),
        ],
      ),
    );
  }
}
