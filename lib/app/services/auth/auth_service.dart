import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class AuthService extends BaseServices {
  Future<Response> login({required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(
        "/auth/login",
        data: data,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioException(
            requestOptions: RequestOptions(path: baseUrl),
            response: response,
            type: DioExceptionType.connectionError,
            message: response.data['message'].toString());
      }
    } on DioException catch (error) {
      checkException(error,
          error.response != null ? error.response!.data['message'] : "Error");
      return Response(statusCode: 400, requestOptions: RequestOptions());
    } catch (e) {
      return Response(statusCode: 400, requestOptions: RequestOptions());
    }
  }

  Future<Response> register({required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(
        "$baseUrl/auth/register",
        data: data,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioException(
            requestOptions: RequestOptions(path: baseUrl),
            response: response,
            type: DioExceptionType.connectionError,
            message: response.data['message'].toString());
      }
    } on DioException catch (error) {
      checkException(error,
          error.response != null ? error.response!.data['message'] : "Error");
      return Response(statusCode: 400, requestOptions: RequestOptions());
    } catch (e) {
      return Response(statusCode: 400, requestOptions: RequestOptions());
    }
  }

  Future<Response> logout() async {
    return await get(path: "/auth/logout");
  }
}
