



        import 'package:easy_localization/easy_localization.dart';
import 'package:evento/main.dart';
import 'package:get/get.dart';

snakBarForError(String subTitle){
 return Get.snackbar(tr("Uncomplete data"), subTitle,
          snackPosition: SnackPosition.TOP,
          backgroundColor: customColors.primaryBackground,
           colorText: customColors.primaryText
          );
        }