import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/features/profile_pages/freinds/model/freinds_model.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

class InviteFreindsToEventController extends GetxController{
   late RxList<FreindsModel> myFreinds;
 late RxList<String> errorMessage;
 late List<bool> initedList;
 late int eventId;
 late String eventNAme;
  @override
  void onInit() async{
     errorMessage = <String>[].obs;
   myFreinds=<FreindsModel>[].obs;
   eventId=Get.arguments[0];
   eventNAme=Get.arguments[1];
   await getMyFreinds();
    super.onInit();
  }
  getMyFreinds() async {
    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ;
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.myFreinds, method: "GEt", token: token);

    dynamic handlingResponse = response.fold((l) => l, (r) => r);
    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
    } else {
      List<dynamic> interestsJson = handlingResponse['friends'];

      myFreinds.value = interestsJson
          .map((jsonItem) => FreindsModel.fromJson(jsonItem))
          .toList();
          initedList=List.generate(myFreinds.length,(index)=>false);
      print(myFreinds.length);
    }
    update();
    }

  onPressInviteFriend(int freindId,int modelId)async{
String token = await prefService.readString("token") ?? "";

  // A list to store error messages.
  List<String> errorMessage = [];

  // The response from the API call, wrapped in Either to handle both success and error cases.
  Either<ErrorResponse, Map<String, dynamic>> response;
Map<String,dynamic>data={
  "event_name":eventNAme,
  "event_id":eventId,
  "user_id":freindId
};
  // Making the API request. The method is set to "GET".
  response = await ApiHelper.makeRequest(
      targetRout: ServerConstApis.inviteEvent,
      method: "post",
      data: data,
      token: token);

  // Handling the response. 'fold' is used to handle both Left (error) and Right (success) cases.
  dynamic handlingResponse = response.fold((l) => l, (r) => r);

  // Check if the handlingResponse is an error.
  if (handlingResponse is ErrorResponse) {
    // If it's an error, extract the error messages.
    errorMessage = handlingResponse.getErrorMessages();

    // Return the first error message.
    
  } else {
    // If the response is successful, return the success message from the response.
initedList[modelId]=true;
update();
  }
  }
} 