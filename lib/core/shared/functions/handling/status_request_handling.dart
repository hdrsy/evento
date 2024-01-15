import '../../../utils/error_handling/erroe_handling.dart';

handlingData(response) {
    if (response is ErrorResponse) {
      return response;
    } else {
      return response;
    }
  }