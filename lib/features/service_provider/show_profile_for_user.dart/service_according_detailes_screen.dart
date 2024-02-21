import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
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
        child: Obx(() => serviceAccordingDetailesController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(children: [
                _buildTopSection(context),
                // SizedBox(
                //   height: 50,
                // ),
                _buildContentSection(),
              ])),
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(
        children: [
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
                      image: serviceAccordingDetailesController
                                  .serviceProvider.profile ==
                              ''
                          ? Image.asset(
                              'assets/images/faceBookProfile.jfif',
                              // fit: BoxFit.,
                              alignment: const Alignment(0, 0),
                            ).image
                          : getImageNetwork(
                                  url:
                                      "/storage/${serviceAccordingDetailesController.serviceProvider.profile}",
                                  width: double.infinity,
                                  height: null)
                              .image)),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: IconWithContainer(
              backgroundColor: customColors.shadow,
              buttonSize: 46,
              borderRadius: 10,
              icon: Icons.arrow_back_rounded,
              iconColor: customColors.info,
              onTap: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          boxShadow: const [
            // BoxShadow(
            //     blurRadius: 4, color: Color(0x320E151B), offset: Offset(0, -2))
          ],
          // borderRadius: const BorderRadius.only(
          //     topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: Column(
            children: [
              NameCheckBox(
                  serviceProvider:
                      serviceAccordingDetailesController.serviceProvider),
              const SizedBox(height: 20),
              Expanded(child: TabBarGalleryAndDetailes()),
            ],
          ),
        ),
      ),
    );
  }
}

class TabBarGalleryAndDetailes extends StatelessWidget {
  TabBarGalleryAndDetailes({Key? key}) : super(key: key);

  final ServiceAccordingDetailesForUserController
      serviceAccordingDetailesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            labelColor: customColors.primary,
            unselectedLabelColor: customColors.primaryText,
            indicatorColor: customColors.primary,
            dividerColor: customColors.secondaryBackground,
            indicatorWeight: 2.0,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: tr("Details")),
              Tab(text: tr("Gallery")),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Padding(
                    padding: const EdgeInsets.all(16), child: DetailesCard()),
                _buildGallery(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGallery() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: serviceAccordingDetailesController.serviceProvider.albums
            .where((album) => album.images.isNotEmpty)
            .map((album) => FolderCard(album: album))
            .toList()
            .divide(SizedBox(
              height: 5.h,
            )),
      ),
    );
  }
}
