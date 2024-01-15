import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/events/event_detailes/controller/event_detailes_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:easy_localization/easy_localization.dart';
class InviteFreinds extends StatelessWidget {
  const InviteFreinds({super.key});

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
                          final EventDetailesController eventDetailesController = Get.find();
  
                          // context.pushNamed('Invite-friends-to-event');
                          Get.toNamed('/InviteFreindsToEventScreen',arguments: [eventDetailesController.eventId,eventDetailesController.eventDetailsModel.title]);
                        },
                        text:tr( "From Friends list"),
                        options: ButtonOptions(
                          width: 200,
                          height: 40,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 24, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: customColors.primary,
                          textStyle: customTextStyle.titleSmall.override(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            useGoogleFonts: true,
                          ),
                          elevation: 3,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Builder(
                        builder: (context) => ButtonWidget(
                          onPressed: () async {
                            await Share.share(
                              'Check out this event in Evento',
                            );
                          },
                          text:tr( "External Share"),
                          options: ButtonOptions(
                            width: 200,
                            height: 40,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 0, 24, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            color: customColors.primary,
                            textStyle: customTextStyle.titleSmall.override(
                              fontFamily: 'Nunito',
                              color: Colors.white,
                              useGoogleFonts: true,
                            ),
                            elevation: 3,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ].divide(const SizedBox(height: 15)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
