import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../model/freinds_model.dart';
import 'un_friend_confirmation_widget.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';

class UnfriendWidget extends StatelessWidget {
  const UnfriendWidget(
      {Key? key, required this.freindsModel, required this.modelId})
      : super(key: key);
  final FreindsModel freindsModel;
  final int modelId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 50,
              child: Divider(
                thickness: 3,
                color: customColors.secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              child: GestureDetector(
                onTap: () async {
                  showButtonSheet(
                      context: context,
                      widget: UnfriendConfirmationWidget(
                          freindsModel: freindsModel, modelId: modelId),
                      height: screenHeight * 0.5);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person_off_outlined,
                      color: customColors.delete,
                      size: 24,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Unfriend ${freindsModel.firstName}",
                          style: customTextStyle.bodyMedium.override(
                            fontFamily: 'Nunito',
                            color: customColors.delete,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: true,
                          ),
                        ),
                        Text(
                          "Remove ${freindsModel.firstName} as a friend",
                          style: customTextStyle.bodyMedium.override(
                            fontFamily: 'Nunito',
                            color: customColors.secondaryText,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: true,
                          ),
                        ),
                      ],
                    ),
                  ].divide(const SizedBox(width: 5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
