import 'package:evento/features/service_provider/show_profile_for_user.dart/controller/ServiceAccordingDetailesForUserController.dart';
import 'package:evento/features/service_provider/show_profile_for_user.dart/model/show_profile_for_user.dart';

import '../../../../../core/server/server_config.dart';
import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../../core/shared/widgets/widget/rate_event_widget.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class NameCheckBox extends StatelessWidget {
  NameCheckBox(
      {super.key,
      required this.serviceProvider,
      });
  final ServiceProvider serviceProvider;
  
  final ServiceAccordingDetailesForUserController serviceAccordingDetailesController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          serviceProvider.name,
          style: customTextStyle.headlineSmall,
        ).tr(),
        Container(
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
          ),
          child:InkWell(
                splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
                onTap: ()async{
                  await showButtonSheet(
              context: context,
              widget:  ReviewEventWidget(ratingTarget:tr( "Service Provider"),id:serviceProvider.id,idKey: "service_provider_id",url: ServerConstApis.reviewServiceProvider, ),
              height: 450);
              },
                child: Text(
                    "Review Service Provider",
                    style: customTextStyle.bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: customColors.primary,
                      fontSize: 12,
                      useGoogleFonts: true,
                    ),
                  ).tr(),
              ),
        ),
      ],
    );
  }
}
