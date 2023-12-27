import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/animation/shimmer_animation.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/going/controller/going_controller.dart';
import 'package:evento/features/going/model/going_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoingScreen extends StatelessWidget {
   GoingScreen({super.key});
final GoingController goingController=Get.put(GoingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.secondaryBackground,
        appBar: AppBar(
          backgroundColor: customColors.secondaryBackground,
          title: Text("Going",
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
        body: Obx(
          ()=> goingController.isLoading.value?Center(child: CircularProgressIndicator(color: customColors.primary,),)
:           SingleChildScrollView(
  padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
            controller: goingController.scrollController,
            child: Column(
              children: [
               
                  ...List.generate(
                                goingController.hasMoreData.value
                                    ? goingController.itemList.length + 1
                                    : goingController.itemList.length,
                                (index) {
                              return index <
                                      goingController.itemList.length
                                  ? GoingCard(
                                      goingModel:
                                          goingController.itemList[index],
                                      
                                    )
                                  : ShimmerLoadingWidget(loadingShimmerWidget:  Container(
                            width: double.infinity,
                            height: screenHeight*0.1,
                            // height: 330 ,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: customColors.info,
                              ),
                              color: customColors.info
                            ),
                          ));
                            })
        
              ].divide(const SizedBox(
                height: 10,
              )),
            ),
          ),
        ));
  }
}

class GoingCard extends StatelessWidget {
  const GoingCard({super.key,required this.goingModel});
final GoingModel goingModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
        child: Container(
          width: screenHeight*0.15,
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
                    child: Image.network(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goingModel.firstName+" "+goingModel.lastName,
                            style: customTextStyle.bodyLarge,
                          ),
                             ButtonWidget(
                                onPressed: () {},
                                text: "Add Freind",
                                options: ButtonOptions(
                                  width: 120,
                                  height: 21,
                                  
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color: customColors.primary,
                                  textStyle:
                                      customTextStyle.titleSmall.override(
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
                        
                        ].divide(const SizedBox(height: 10)),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
