import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/map/controller/map_controller.dart';
import 'package:evento/features/map/view/widgets/element.dart';
import 'package:evento/features/map/view/widgets/levents_list.dart';
import 'package:evento/features/map/view/widgets/map_widget.dart';
import 'package:evento/main.dart';
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
                  .copyWith(color: customColors.primary, fontSize: 20)),
          centerTitle: true,
          leading: InkWell(
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
            const ElementWidget(),  

            Align(
              alignment: const AlignmentDirectional(1,1),
              child: EventsList()),

Align(
  alignment: const AlignmentDirectional(0.96, 0.34),
  child: Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
    child: ButtonWidget(
      onPressed: () async {
        // context.pushNamed('Search');
      },
      text: '',
      icon: const Icon(
        Icons.list,
        size: 30,
      ),
      options: ButtonOptions(
        height: 40,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
)

           ],
        ));
  }
}
