import 'package:dio/dio.dart';

class APIException {
  List<String> getExceptionMessage(DioException exception, String message) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return ["Bad Response", message];

      case DioExceptionType.connectionError:
        return ["Connection Error", message];

      case DioExceptionType.connectionTimeout:
        return ["Connection Timeout", message];

      case DioExceptionType.unknown:
        return ["Something Went Wrong", message];

      case DioExceptionType.cancel:
        return ["Request Cancelled", message];

      case DioExceptionType.receiveTimeout:
        return ["Receive Timeout", message];

      case DioExceptionType.sendTimeout:
        return ["Send Timeout", message];

      default:
        return ["Unknown Error", message];
    }
  }
}
