import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final RxBool isConnected = false.obs;
  bool _firstCheck = true; // Add flag to track the first connectivity check

  Future<ConnectivityService> init() async {
    var initialStatus = await Connectivity().checkConnectivity();
    isConnected.value = initialStatus != ConnectivityResult.none;

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      bool previousState = isConnected.value;
      isConnected.value = result != ConnectivityResult.none;

      // Only show snackbar if it's not the first check and there was a change
      if (!_firstCheck && previousState != isConnected.value) {
        if (isConnected.value) {
          // Show "back online" snackbar
        } else {
          // Show "offline" snackbar
        }
      }
      _firstCheck = false; // Update flag after handling first check
    });
    return this;
  }
}
