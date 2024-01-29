import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/buttons/icon_with_container.dart';
import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../model/service_category_model.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {super.key,
      required this.serviceCategoryModel,
      required this.serviceCategoryIndex});
  final ServiceCategoryModel serviceCategoryModel;
  final int serviceCategoryIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/ServiceAccordingCategoryScreen', arguments: [
          serviceCategoryModel.id,
          serviceCategoryModel.title,
          serviceCategoryIndex,
          true
        ]);
      },
      child: Stack(
        alignment: const AlignmentDirectional(0, 1),
        children: [
          Container(
            height: screenHeight * 0.17,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: const AlignmentDirectional(0.00, 0.20),
                image: getImageNetwork(
                        url: serviceCategoryModel.icon,
                        width: null,
                        height: null)
                    .image,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
            height: screenHeight * 0.17,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF050606), Color(0x00EE8B60)],
                stops: [0, 0.7],
                begin: AlignmentDirectional(-1, 0),
                end: AlignmentDirectional(1, 0),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceCategoryModel.title,
                          style: customTextStyle.bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: customColors.info,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: false,
                          ),
                        ),
                        Text(
                          serviceCategoryModel.description,
                          style: customTextStyle.bodyMedium.override(
                            fontFamily: 'Nunito',
                            color: customColors.info,
                            fontSize: 12,
                            useGoogleFonts: true,
                          ),
                        ),
                      ].divide(const SizedBox(height: 5)),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconWithContainer(
                        borderRadius: 20,
                        buttonSize: 40,
                        iconColor: customColors.info,
                        backgroundColor: customColors.primary,
                        icon: Icons.arrow_forward,
                        onTap: () async {
                          // context.pushNamed('Venuelist');
                        },
                      ),
                    ].addToEnd(const SizedBox(height: 30)),
                  ),
                ].divide(const SizedBox(width: 60)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
