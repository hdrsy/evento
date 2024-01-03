import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/helper/date_formatter.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/my_request/model/my_request_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.myRequestModel});
final MyRequestModel myRequestModel;
  @override
  Widget build(BuildContext context) {
    return // Generated code for this Stack Widget...
        Stack(
      alignment: const AlignmentDirectional(0, 1),
      children: [
        Container(
          width: 354,
          height: 138,
          decoration: BoxDecoration(
            color: customColors.secondaryBackground,
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: const AlignmentDirectional(0.00, -0.70),
              image: Image.asset(
                'assets/images/pexels-wolfgang-2747446.jpg',
              ).image,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x34090F13),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.00, 0.00),
          child: Container(
            width: 354,
            height: 138,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image:myRequestModel.images.isEmpty? Image.asset('assets/images/pexels-wolfgang-2747446.jpg')
                    .image:getImageNetwork(url: "/storage/${myRequestModel.images[0]}", width: null, height: null).image,
              ),
              gradient: const LinearGradient(
                colors: [Color(0xFF050606), Color(0x00EE8B60)],
                stops: [0, 0.7],
                begin: AlignmentDirectional(-1, 0),
                end: AlignmentDirectional(1, 0),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.00, 0.00),
                    child: Text(
                      myRequestModel.title,
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.info,
                        fontSize: 16,
                        useGoogleFonts: true,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
                        child: Icon(
                          Icons.wc_rounded,
                          color: customColors.info,
                          size: 15,
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.00, 0.00),
                        child: Text(
                          "Wedding / ${DateFormatter.formatDate(myRequestModel.date)}",
                          style: customTextStyle.bodyMedium.override(
                            fontFamily: 'Nunito',
                            color: customColors.info,
                            fontSize: 12,
                            useGoogleFonts: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.00, 0.00),
                        child: Text(
                          "${myRequestModel.startTime} , ${myRequestModel.endTime}",
                          style: customTextStyle.bodyMedium.override(
                            fontFamily: 'Nunito',
                            color: customColors.info,
                            fontSize: 12,
                            useGoogleFonts: true,
                          ),
                        ),
                      ),
                      ButtonWidget(
                        onPressed: () async {
                          // context.pushNamed('Reque-ststatus');
                          Get.toNamed('/RequestStatusScreen');
                        },
                        text: "See details",
                        options: ButtonOptions(
                          height: 21,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: customColors.primary,
                          textStyle: customTextStyle.titleSmall.override(
                            fontFamily: 'Nunito',
                            color: customColors.info,
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: true,
                          ),
                          borderSide: BorderSide(
                            color: customColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ].divide(const SizedBox(height: 5)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
