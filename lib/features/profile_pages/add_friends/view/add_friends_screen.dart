import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/shared/widgets/images/network_image.dart';
import 'package:evento/core/shared/widgets/text_fields/search_filed.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/features/going/view/going_screen.dart';
import 'package:evento/features/profile_pages/add_friends/controller/add_friends_controller.dart';
import 'package:evento/features/profile_pages/add_friends/model/add_friends_model.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFriendsScreen extends StatelessWidget {
   AddFriendsScreen({super.key});
final AddFriendsController addFriendsController=Get.put(AddFriendsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: customColors.secondaryBackground,
        title: Text("Add Freinds",
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
            padding: padding(10,16,0,16),
            child: Column(children: [
              searchTextField(onChanged: (value){}),
             ...List.generate(addFriendsController.addFriendsList.length, (index) =>AddFriendCard(addFriendsModel:addFriendsController.addFriendsList[index] ,modelId: index,))
            ].divide(const SizedBox(height: 15,))
            ,),
          ),
    );
  }
}
class AddFriendCard extends StatelessWidget {
  const AddFriendCard({super.key, required this.addFriendsModel, required this.modelId});
  final AddFriendsModel addFriendsModel;
  final int modelId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFriendsController>(builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 1),
          child: Container(
            width: screenHeight * 0.15,
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
                      child: addFriendsModel.image.length > 6
                ? getImageNetwork(
                    url: "/storage/${addFriendsModel.image}",
                    width: null,
                    height: null)
                : Image.asset(
                    'assets/images/${addFriendsModel.image}.png')),
        
                    
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${addFriendsModel.firstName} ${addFriendsModel.lastName}",
                              style: customTextStyle.bodyLarge,
                            ),
AddFriendButton(
        userId: addFriendsModel.id,
        modelId: modelId,
      )
                          ].divide(const SizedBox(height: 10)),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }

  
}
