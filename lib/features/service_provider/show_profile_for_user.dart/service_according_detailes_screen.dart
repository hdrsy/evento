import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/empty_data/empty_data_widget.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/shared/widgets/buttons/icon_with_container.dart';
import 'package:evento/features/service_provider/show_profile_for_user.dart/controller/ServiceAccordingDetailesForUserController.dart';
import 'widgets/detailes_card.dart';
import 'widgets/name_check_box.dart';
import 'widgets/folder_card.dart';
import 'widgets/top_image_network.dart';

class ServiceAccordingDetailesForUserScreen extends StatelessWidget {
  ServiceAccordingDetailesForUserScreen({Key? key}) : super(key: key);

  final ServiceAccordingDetailesForUserController
      serviceAccordingDetailesController =
      Get.put(ServiceAccordingDetailesForUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      body: SafeArea(
        child: Obx(
          () => serviceAccordingDetailesController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : serviceAccordingDetailesController.isError.value
                  ? EmptyData(
                      icon: Icons.error_outline_outlined,
                      message: "SomeThing Wrong!!",
                    )
                  : Column(
                      children: [
                        Container(
                          height: 400.h,
                          child: Stack(children: [
                            TopImageWidget(
                              imageUrl:
                                  "${ServerConstApis.baseAPI}/storage/${serviceAccordingDetailesController.serviceProvider.cover}",
                            ),
                            Positioned(
                              bottom: 0,
                              left: 20,
                              child: Container(
                                width: screenWidth * 0.3,
                                height: screenWidth * 0.3,
                                decoration: BoxDecoration(
                                    color: customColors.primaryBackground,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: customColors.secondaryBackground,
                                      width: 2,
                                    ),
                                    image: DecorationImage(
                                        image: getImageNetwork(
                                                url:
                                                    "/storage/${serviceAccordingDetailesController.serviceProvider.profile}",
                                                width: double.infinity,
                                                height: null)
                                            .image)),
                              ),
                            ),
                            Align(
                              alignment:
                                  const AlignmentDirectional(-0.95, -0.95),
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
                          ]),
                        ),
                        Expanded(
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24, 12, 24, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  NameCheckBox(
                                    serviceProvider:
                                        serviceAccordingDetailesController
                                            .serviceProvider,
                                  ),
                                  const SizedBox(height: 20),
                                  Expanded(child: TabBarGalleryAndDetailes())
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class TabBarGalleryAndDetailes extends StatelessWidget {
  TabBarGalleryAndDetailes({super.key});
  final ServiceAccordingDetailesForUserController
      serviceAccordingDetailesController = Get.find();
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
              indicatorWeight: 2.0,
              dividerColor: customColors.secondaryBackground,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: tr("Details")),
                Tab(text: tr("Gallery")),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: DetailesCard()),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ...List.generate(
                            serviceAccordingDetailesController
                                .serviceProvider.albums.length,
                            (index) => FolderCard(
                                  album: serviceAccordingDetailesController
                                      .serviceProvider.albums[index],
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
