import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/profile_pages/my_request/view/widget/request_card.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyrequestScreen extends StatelessWidget {
  const MyrequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("My Requests",
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
      body: SingleChildScrollView(
        padding: padding(16, 20, 10, 20),
        child: Column(
          children: [
            searchTextField(onChanged: (value) {}),
            // Generated code for this Row Widget...
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                  child: Text(
                    "24",
                    style: customTextStyle.labelMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 12, 16, 0),
                  child: Text(
                    "Event",
                    style: customTextStyle.bodyMedium,
                  ),
                ),
              ],
            ),
            const RequestCard(),
            const RequestCard(),
            const RequestCard(),
            const RequestCard(),
            const RequestCard(),
          ].divide(const SizedBox(height: 10,)),
        ),
      ),
    );
  }
}
