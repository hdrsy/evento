import '../../../../core/shared/widgets/text_fields/search_filed_with_filtering.dart';
import '../../../../core/utils/helper/flutter_flow_util.dart';
import '../../controller/map_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElementWidget extends StatelessWidget {
  ElementWidget({super.key});
  final MapController mapController = Get.find();
  @override
  Widget build(BuildContext context) {
    return // Generated code for this Column Widget...
        Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 10),
          child: Container(
            width: double.infinity,
            // height: 45,
            decoration: BoxDecoration(
              color: customColors.primaryBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: customColors.primaryBackground,
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child: GestureDetector(
                onTap: () {
                  mapController.isSearchActive.value = true;
                },
                child: SearchFieldWithFiltering(
                    controller: mapController.searchField,
                    onChanged: (value) {
                      // mapController.onPressSearch(value);
                    },
                    onApplyFilters: (filters) {
                      mapController.onApplyFilters(filters);
                    }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
