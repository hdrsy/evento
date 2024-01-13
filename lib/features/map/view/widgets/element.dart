import 'package:evento/core/shared/widgets/buttons/icon_with_container.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed_with_filtering.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/map/controller/map_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElementWidget extends StatelessWidget {
   ElementWidget({super.key});
final  MapController mapController=Get.find();
  @override
  Widget build(BuildContext context) {
    return // Generated code for this Column Widget...
Column(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 290,
            // height: 45,
            decoration: BoxDecoration(
              color:customColors.primaryBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color:customColors.primaryBackground,
              ),
            ),
            child:  Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              child:  searchTextField(onChanged: (value){
 mapController.onPressSearch(value!);
    
              },
              controller: mapController.searchController
              ),
                 ),
          ),
          IconWithContainer(
            borderRadius: 10,
            
            iconColor: customColors.secondaryBackground,
            buttonSize: 45,
            backgroundColor:customColors.secondaryText ,
 
            icon:
              Icons.location_searching,
               
            onTap: () {
            },
          ),
        ].divide(const SizedBox(width: 20)),
      ),
    ),
  ],
)
;
  }
}