import 'package:easy_localization/easy_localization.dart';

import '../../../core/shared/widgets/buttons/general_button.dart';
import '../../../core/utils/theme/text_theme.dart';
import '../controller/map_controller.dart';
import 'widgets/element.dart';
import 'widgets/levents_list.dart';
import 'widgets/map_widget.dart';
import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});
  final MapController mapController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text("Map",
                  style: customTextStyle.bodyMedium
                      .copyWith(color: customColors.primary, fontSize: 20))
              .tr(),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: customColors.primaryText,
              size: 30,
            ),
          ),
        ),
        body: Stack(
          children: [
            MapWidget(),
            ElementWidget(),
            Align(
                alignment: const AlignmentDirectional(1, 1),
                child: EventsList()),
            Align(
              alignment: const AlignmentDirectional(0.96, 0.34),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                    child: ButtonWidget(
                      onPressed: () async {
                        Get.back();
                      },
                      text: '',
                      icon: const Icon(
                        Icons.list,
                        size: 30,
                      ),
                      options: ButtonOptions(
                        height: 40,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                    child: ButtonWidget(
                      onPressed: () async {
                        mapController.moveCamiraPosition();
                      },
                      text: '',
                      icon: const Icon(
                        Icons.location_searching_sharp,
                        size: 30,
                      ),
                      options: ButtonOptions(
                        height: 40,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
