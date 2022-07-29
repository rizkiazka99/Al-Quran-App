import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class ApiProvider {
  Dio dio = Dio();
  String baseUrl = 'http://api.alquran.cloud/v1/';

  getResponse(statusCode, message, data) {
    return {
      'code': statusCode,
      'status': message,
      'data': data
    };
  }

  handleError(error) {
    String errorDescription = '';
    DioError? dioError;

    if (error is DioError) {
      dioError = error as DioError;
      switch(dioError.type) {
        case DioErrorType.cancel:
          errorDescription = 'Request to the server was cancelled';
          break;
        case DioErrorType.connectTimeout:
          errorDescription = 'Connection timeout to the server';
          break;
        case DioErrorType.other:
          errorDescription = 'Unknown error occurred';
          break;
        case DioErrorType.sendTimeout:
          errorDescription = 'Send timeout in connection to the server';
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = 'Receive timeout in connection to the server';
          break;
        case DioErrorType.response:
          errorDescription = "${dioError.response!.data['status']}";
          break;
      }
    } else {
      errorDescription = 'Unexpected error occurred';
    }

    return getResponse(
      dioError!.response!.statusCode, 
      errorDescription, 
      dioError.response!.data['error_data']
    );
  }

  Future dioGet(url, {query}) async {
    try {
      final response = await dio.get(
        baseUrl + url,
        queryParameters: query == null ? null : Map.from(query),
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          },
          contentType: 'application/json',
          validateStatus: (status) {
            if (status == HttpStatus.ok ||
                status == HttpStatus.accepted ||
                status == HttpStatus.created) {
              return true;
            } else {
              return false;
            }
          }
        )
      );
      
      return getResponse(
        response.data['code'], 
        response.data['status'], 
        response.data['data']
      );
    } catch (e) {
      return handleError(e);
    }
  }

  Future getSurah() async {
    return await dioGet('surah');
  }
}