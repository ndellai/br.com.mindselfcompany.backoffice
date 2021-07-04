import 'package:br_com_mindselfcompany_backoffice_web/constants/api_routes.dart';
import 'package:br_com_mindselfcompany_backoffice_web/dto/employee_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/pagination_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/base_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/upload_file_service.dart';

class EmployeeRepository extends BaseRepository {
  final HttpService httpService;
  final UploadFileService uploadFileService;
  EmployeeRepository(this.httpService, this.uploadFileService)
      : super(httpService);

  Future<ApiResultModel<PaginationModel>> listEmployee(
      EmployeeDto answerDto, int actualPage) async {
    var response = await httpService.invokeApi<EmployeeDto>(
        method: Method.POST,
        route: ApiRoutes.employeeLst,
        data: answerDto,
        header: Header.No,
        parameters: "actualPage=" + actualPage.toString());

    return ApiResultModel<PaginationModel>(
        message: response.message,
        data: PaginationModel(
            totalPages: response.data["totalPages"],
            pagedList: response.data["pagedList"]));
  }

  Future<ApiResultModel<bool>> insertEmployee(EmployeeDto answerDto) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.employeeAdd,
        data: answerDto,
        header: Header.Yes);

    return ApiResultModel<bool>(message: response.message, data: response.data);
  }

  Future<ApiResultModel<PaginationModel>> getEmployee(
      EmployeeDto answerDto, int actualPage) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.employeeLst,
        data: answerDto,
        header: Header.Yes,
        parameters: "actualPage=" + actualPage.toString());

    return ApiResultModel<PaginationModel>(
        message: response.message,
        data: PaginationModel(
            totalPages: response.data["totalPages"],
            pagedList: response.data["pagedList"]));
  }

  Future<ApiResultModel<bool>> updateEmployee(EmployeeDto answerDto) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.employeeEdt,
        data: answerDto,
        header: Header.Yes);

    return ApiResultModel<bool>(message: response.message, data: response.data);
  }

  Future<ApiResultModel<bool>> deleteEmployee(EmployeeDto answerDto) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.employeeDel,
        data: answerDto,
        header: Header.Yes);

    return ApiResultModel<bool>(message: response.message, data: response.data);
  }

  Future<ApiResultModel<bool>> makeUpload(
      List<int> fileUpload, bool hasHeader, int idCompany) async {
    var response = await uploadFileService.makeUpload(
        route: ApiRoutes.employeeUpl,
        fileUpload: fileUpload,
        idCompany: idCompany,
        hasHeader: hasHeader);

    return ApiResultModel<bool>(message: response.message, data: response.data);
  }
}
