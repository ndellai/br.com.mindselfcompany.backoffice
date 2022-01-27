import 'dart:convert';

import 'package:br_com_mindselfcompany_backoffice_web/flavors/setup.dart';
import 'package:get/get.dart';

import 'model/api_result_vo.dart';

enum Method { POST, GET }
enum Header { Yes, No }

class HttpService extends GetConnect {
  final String contentType = "application/json";

  Future<ApiResultVO> invokeApi<T>(
      {Method method,
      String route,
      T data,
      Header header,
      String parameters}) async {
    Response response;

    print(method);
    print(route);
    print(header);
    print(jsonEncode(data));
    print(
      "${Setup.apiBaseUrl}$route" +
          ((parameters ?? "").isEmpty ? "" : "?" + parameters),
    );

    try {
      switch (method) {
        case Method.GET:
          response = await get(
              "${Setup.apiBaseUrl}$route" +
                  ((parameters ?? "").isEmpty ? "" : "?" + parameters),
              contentType: contentType,
              headers: (header == Header.Yes ? await _getHeader() : null));
          break;
        default:
          response = await post(
              "${Setup.apiBaseUrl}$route" +
                  ((parameters ?? "").isEmpty ? "" : "?" + parameters),
              jsonEncode(data),
              contentType: contentType,
              headers: (header == Header.Yes ? await _getHeader() : null));
          break;
      }

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return ApiResultVO.fromJson(response.body);
      } else {
        return ApiResultVO(
            code: response.statusCode, message: response.statusText);
      }
    } catch (e) {
      return ApiResultVO(code: 500, message: e.toString());
    }
  }

  Future<Map<String, String>> _getHeader() async {
    //return {"authorizarion": F.token};
    return {"Authorization": ""};
  }
}
