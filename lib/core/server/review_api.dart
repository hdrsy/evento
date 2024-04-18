import 'package:dartz/dartz.dart';
import 'helper_api.dart';
import '../utils/error_handling/erroe_handling.dart';
import '../../main.dart';

/// Makes an API call to follow or unfollow an event based on the provided URL.
///
/// [url] - The endpoint URL for following or unfollowing an event.
/// Returns a `Future<String>` which is either a success message or the first error message.
Future<bool> review(
    {required String url,
    required int rating,
    required String desc,
    required String idKey,
    required int id}) async {
  print("dddddddddddddd :${idKey}");

  // Read the stored token from preferences. A fallback empty string is used if it's null.
  String token = await prefService.readString("token");

  // A list to store error messages.

  // The response from the API call, wrapped in Either to handle both success and error cases.
  Either<ErrorResponse, Map<String, dynamic>> response;
  Map<String, dynamic> data = {
    idKey: id,
    "rate": rating,
    "comment": desc,
  };
  // Making the API request. The method is set to "GET".
  response = await ApiHelper.makeRequest(
      targetRout: url, method: "post", data: data, token: token);

  // Handling the response. 'fold' is used to handle both Left (error) and Right (success) cases.
  dynamic handlingResponse = response.fold((l) => l, (r) => r);
  // Check if the handlingResponse is an error.
  if (handlingResponse is ErrorResponse) {
    // If it's an error, extract the error messages.

    // Return the first error message.
    return false;
  } else {
    // If the response is successful, return the success message from the response.
    return true;
  }
}
