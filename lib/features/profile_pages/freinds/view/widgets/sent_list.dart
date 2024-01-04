import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/freinds/controller/freinds_cotroller.dart';
import 'package:evento/features/profile_pages/freinds/model/send_request.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SentList extends StatelessWidget {
  SentList({super.key});
  final FreindsController freindsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FreindsController>(
      builder: (ccontext) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Sent requests ",
                            style: customTextStyle.bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: customColors.primaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: true,
                            ),
                          ),
                          TextSpan(
                            text: "${freindsController.sentFreinds.length}",
                            style: TextStyle(
                              color: customColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                        style: customTextStyle.bodyMedium,
                      ),
                    ),
                    Text(
                      "Manage",
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.primary,
                        fontSize: 12,
                        useGoogleFonts: false,
                      ),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                  freindsController.sentFreinds.length,
                  (index) => SentCard(
                        sentRequest: freindsController.sentFreinds[index],
                        modelId: index,
                      ))
            ].divide(const SizedBox(
              height: 10,
            )),
          ),
        );
      }
    );
  }
}

class SentCard extends StatelessWidget {
  const SentCard({super.key, required this.sentRequest, required this.modelId});
  final SentRequest sentRequest;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
        child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: customColors.secondaryBackground,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: sentRequest.receiver.image.length > 6
                          ? getImageNetwork(
                              url: "/storage/${sentRequest.receiver.image}",
                              width: 90,
                              height: 90)
                          : Image.asset(
                              'assets/images/${sentRequest.receiver.image}.png')),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${sentRequest.receiver.firstName} ${sentRequest.receiver.lastName}",
                            style: customTextStyle.bodyLarge,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonWidget(
                                onPressed: () {
                                  final FreindsController freindsController =
                                      Get.find();
                                  freindsController.cancelSentRequest(
                                      sentRequest.receiverId, modelId);
                                },
                                text: "Cancel",
                                options: ButtonOptions(
                                  width: 200,
                                  height: 20,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color: customColors.secondaryBackground,
                                  textStyle:
                                      customTextStyle.titleSmall.override(
                                    fontFamily: 'Nunito',
                                    color: customColors.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: true,
                                  ),
                                  borderSide: BorderSide(
                                    color: customColors.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ].divide(const SizedBox(height: 10)),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
