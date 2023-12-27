import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/buttons/icon_with_container.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';

import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/customize_event/venue_detailes/controller/venue_detailes_controller.dart';
import 'package:evento/features/customize_event/venue_detailes/view/widgets/detailes_card.dart';
import 'package:evento/features/customize_event/venue_detailes/view/widgets/name_check_box.dart';
import 'package:evento/features/customize_event/venue_detailes/view/widgets/serives_card.dart';
import 'package:evento/features/customize_event/venue_detailes/view/widgets/top_image_network.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueDetailesScreen extends StatelessWidget {
  VenueDetailesScreen({super.key});
  final VenueDetailesController venueDetailesController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      body: SafeArea(
        child: Stack(children: [
           TopImageWidget(
            imageUrl:ServerConstApis.baseAPI+  "/storage/ServiceProviderProfileImages/cdEJcxInSvmH6KxthPbVCOBRb1bJ7D3DeSGcvZYK.png",
                        
                
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
            child: Expanded(
              child: Container(
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      NameCheckBox(
                          venue: venueDetailesController
                              .venue,
),
                      const SizedBox(height: 20),
                      Expanded(child: TabBarGalleryAndDetailes())
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class TabBarGalleryAndDetailes extends StatelessWidget {
  TabBarGalleryAndDetailes({super.key});
  final VenueDetailesController venueDetailesController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Align(
            alignment: const Alignment(0, 0),
            child: TabBar(
              labelColor: customColors.primary,
              unselectedLabelColor: customColors.grayIcon,
              labelStyle: customTextStyle.titleSmall.override(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                useGoogleFonts: true,
              ),
              unselectedLabelStyle: const TextStyle(),
              indicatorColor: customColors.primary,
              indicatorWeight: 4,
              tabs: const [
                Tab(text: "Details"),
                Tab(text: "Gallery"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                 Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: VenueDetailesCard()
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ...List.generate(
                            venueDetailesController
                                .venue.venueAlbums.length,
                            (index) => VenueServicesCard(
                                  album: venueDetailesController.venue.venueAlbums[index],
                                ))
                      ]
                          .divide(const SizedBox(
                            height: 16,
                          ))
                          .addToStart(const SizedBox(
                            height: 16,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
