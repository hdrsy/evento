import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/book_now/controller/book_now_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilldataWidget extends StatelessWidget {
  const FilldataWidget({Key? key, required this.ticketIndex}) : super(key: key);
final int ticketIndex;
  @override
  Widget build(BuildContext context) {
    
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                child: Divider(
                  thickness: 3,
                  color: customColors.secondary,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ButtonWidget(
                      onPressed: () async {
                      final  BookNowController bookNowController=Get.find();
                        bookNowController.onPressFillMyData(ticketIndex);
                        Get.back();

                      },
                      text:  "My data",
                      options: ButtonOptions(
                        width: 200,
                        height: 40,
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color:customColors.primary,
                        textStyle:
                            customTextStyle.titleSmall.override(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  useGoogleFonts: false,
                                ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    ButtonWidget(
                      onPressed: () async {
                   final      BookNowController bookNowController=Get.find();
                       
                        Get.toNamed('/AssignFriendsScreen',arguments: [bookNowController.myFreinds,ticketIndex]);
                      },
                      text:  "Friends list",
                      options: ButtonOptions(
                        width: 200,
                        height: 40,
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.primary,
                        textStyle:
                            customTextStyle.titleSmall.override(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  useGoogleFonts: false,
                                ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ].divide(const SizedBox(height: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
