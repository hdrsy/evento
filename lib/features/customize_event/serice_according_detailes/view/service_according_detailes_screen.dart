import 'package:evento/core/shared/widgets/buttons/icon_with_container.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/customize_event/serice_according_detailes/controller/service_according_detailes_controller.dart';
import 'package:evento/features/customize_event/serice_according_detailes/view/widgets/name_check_box.dart';
import 'package:evento/features/customize_event/serice_according_detailes/view/widgets/serives_card.dart';
import 'package:evento/features/customize_event/serice_according_detailes/view/widgets/top_image_network.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceAccordingDetailesScreen extends StatelessWidget {
  ServiceAccordingDetailesScreen({super.key});
  final ServiceAccordingDetailesController serviceAccordingDetailesController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      body: SafeArea(
        child: Stack(children: [
          const TopImageWidget(
            imageUrl:
                'https://images.unsplash.com/photo-1632932197818-6b131c21a961?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjIyfHx1c2VyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
          ),
          Align(
            alignment: const AlignmentDirectional(-0.95, -0.95),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: const Color(0x3A000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconWithContainer(
                backgroundColor: Colors.transparent,
                buttonSize: 46,
                borderRadius: 10,
                icon: Icons.arrow_back_rounded,
                iconColor: customColors.info,
                onTap: () {
                  Get.back();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 300, 0, 0),
            child: Container(
              // width: double.infinity,
              decoration: BoxDecoration(
                color: customColors.secondaryBackground,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x320E151B),
                    offset: Offset(0, -2),
                  )
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const NameCheckBox(),
                      ...List.generate(
                          serviceAccordingDetailesController
                              .serviceProvider.albums.length,
                          (index) => ServicesCard(album: serviceAccordingDetailesController
                              .serviceProvider.albums[index],))
                    ].divide(const SizedBox(
                      height: 20,
                    )),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
