import 'package:br_com_mindselfcompany_backoffice_web/flavors/setup.dart';

import 'model/api_result_vo.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadFileService {
  Future<ApiResultVO> makeUpload(
      {String route,
      List<int> fileUpload,
      bool hasHeader,
      int idCompany}) async {
    Response response;

    print(route);
    print(hasHeader);
    print(idCompany);
    print(fileUpload.length);
    print("${Setup.apiBaseUrl}$route");

    try {
      var formData = FormData.fromMap({
        'idCompany': idCompany.toString(),
        'hasHeader': hasHeader.toString(),
        'files': MultipartFile.fromBytes(fileUpload,
            filename: "import.csv",
            contentType: MediaType('application', 'octet-stream'))
      });

      var dio = Dio();

      response = await dio.post("${Setup.apiBaseUrl}$route", data: formData);

      print(response.statusCode);

      if (response.statusCode == 200) {
        return ApiResultVO.fromJson(response.data);
      } else {
        return ApiResultVO(
            code: response.statusCode,
            message: response.statusMessage,
            data: false);
      }
    } catch (e) {
      return ApiResultVO(code: 500, message: e.toString(), data: false);
    }
  }
}
