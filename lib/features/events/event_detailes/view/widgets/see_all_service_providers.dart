import '../../../../../core/shared/widgets/images/network_image.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../model/event_detailes_model.dart';
import '../../../../../main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
class SeeAllServiceProviders extends StatelessWidget {
  const SeeAllServiceProviders({super.key, required this.allServiceProviders});
final List<ServiceProvider> allServiceProviders;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text(tr("My Freinds"),
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
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child:Column(     children: [             ...List.generate(
                      allServiceProviders.length,
                      (index) => AllServiceProviderCard(
                            freindsModel: allServiceProviders[index],
                            modelId: index,
                          ))
                ].divide(const SizedBox(
                  height: 10,
                )),
              ),
        )
    );
  }
}

class AllServiceProviderCard extends StatelessWidget {
  const AllServiceProviderCard({super.key, required this.freindsModel, required this.modelId});
  final ServiceProvider freindsModel;
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
                  child:  freindsModel.profile.length > 6
                ? getImageNetwork(
                    url: "/storage/${freindsModel.profile}",
                    width: 90,
                    height: 90)
                : Image.asset(
                    'assets/images/${freindsModel.profile}.png',width: 90,height: 90,),
       
                  
                 
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      freindsModel.name,
                      style: customTextStyle.bodyLarge,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
