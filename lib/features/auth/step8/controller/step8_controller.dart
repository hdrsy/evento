
import 'package:dartz/dartz.dart';
import '../../../../core/server/helper_api.dart';
import '../../../../core/server/server_config.dart';
import '../../../../core/utils/error_handling/erroe_handling.dart';
import '../../../../core/utils/services/user_info.dart';
import '../../step7/model/interst_model.dart';
import '../../steps/controller/steps_controller.dart';
import '../../../../main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Step8Controller extends GetxController {
  late List<String> states;
  late String? selectedState;
  late RxBool isLoading;
  late RxList<String> errorMessage;
  @override
  void onInit() {
    states = [
      'Aleppo',
      'Al-Ḥasakah',
      'Al-Qamishli',
      'Al-Qunayṭirah',
      'Al-Raqqah',
      'Al-Suwayda',
      'Damascus',
      'Daraa',
      'Dayr al-Zawr',
      'Ḥamah',
      'Homs',
      'Idlib',
      'Latakia',
      'Rif Dimashq'
    ];
    isLoading = false.obs;
    errorMessage = <String>[].obs;
    selectedState = null;
    super.onInit();
  }

  onPressContune() async {
    errorMessage.clear();
    if (selectedState == null) {
      errorMessage.add("Please Select Your State");
    } else {
      isLoading.value=true;
   bool isDoneSignUp2=await signUpStep2();
   bool isDoneinsertInterest=await storeUserInterest();
     if(isDoneinsertInterest && isDoneSignUp2){
      whenSendDataSuccess();
      isLoading.value=false;
     }else{
      isLoading.value=false;
     }
    }
  }

  whenSendDataSuccess() async {
     user=await UserInfo.getUserInfo();
     prefService.createString("isCompleteProfile", "true");
     isGuset=false;
       targetRout == '/home';
   
     Get.offAllNamed('/home');

  }
  Future<bool> signUpStep2() async {
    StepsController stepsController = Get.find();

    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";

    Map<String, String> data = getDataFromAllSteps();
    data.containsKey('image')
        ? response = await ApiHelper.makeRequest(
            targetRout: ServerConstApis.signUpStep2,
            method: "Post",
            token: token,
            data: data)
        : response = await ApiHelper.makeRequest(
            targetRout: ServerConstApis.signUpStep2,
            method: "Post",
            token: token,
            data: data,
            files: {"image": stepsController.customImage});
    dynamic handlingResponse = response.fold((l) => l, (r) => r);

    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
      return false;
    } else {
       return true;
    }
  }

  Future<bool> storeUserInterest() async {
    StepsController stepsController = Get.find();

    Either<ErrorResponse, Map<String, dynamic>> response;
    String token = await prefService.readString("token") ?? "";
    List<InterestItem> interestList = stepsController.interestList;
    List<int> interestIndex = [];
    for (var i = 0; i < interestList.length; i++) {
      interestIndex.add(interestList[i].id);
    }
    response = await ApiHelper.makeRequest(
        targetRout: ServerConstApis.storeUserInterest,
        method: "POST",
        token: token,
        data: {"interest":interestIndex});
    dynamic handlingResponse = response.fold((l) => l, (r) => r);

    if (handlingResponse is ErrorResponse) {
      errorMessage.value = handlingResponse.getErrorMessages();
      isLoading.value = false;
      return false;
    } else {
      return true;
    }
  }

  Map<String, String> getDataFromAllSteps() {
    Map<String, String> data = {};
    StepsController stepsController = Get.find();
    data['password'] = stepsController.password.text;
    data['gender'] = stepsController.isMale.value ? "male" : "female";
    data['birth_date'] = DateFormat('yyyy/M/d').format(stepsController.day!);
    data['state'] = selectedState!;
    stepsController.avatarList[stepsController.selectedProfileindex] is String
        ? data['image'] = stepsController.selectedProfileindex.toString()
        : null;

    return data;
  }
}
