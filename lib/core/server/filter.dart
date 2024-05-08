import 'package:dartz/dartz.dart';
import 'package:evento/core/server/helper_api.dart';
import 'package:evento/core/server/server_config.dart';
import 'package:evento/core/utils/error_handling/erroe_handling.dart';
import 'package:evento/main.dart';

filter(Map<String, dynamic> data, {String? url}) async {
  // Read the stored token from preferences. A fallback empty string is used if it's null.
  String token = await prefService.readString("token");

  // A list to store error messages.
  List<String> errorMessage = [];

  // The response from the API call, wrapped in Either to handle both success and error cases.
  Either<ErrorResponse, Map<String, dynamic>> response;

  // Making the API request. The method is set to "GET".
  response = await ApiHelper.makeRequest(
      targetRout: url ??
          (isGuset ? ServerConstApis.filterForGuest : ServerConstApis.filter),
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
    return errorMessage.first;
  } else {
    List<dynamic> categoryListJson = handlingResponse['events'];
    return categoryListJson;
  }
}
