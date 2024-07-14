import 'package:br_com_mindselfcompany_backoffice_web/constants/api_routes.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/page_count.dart';
import 'package:br_com_mindselfcompany_backoffice_web/dto/company_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/company_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/pagination_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/base_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';

import '../dto/application_dto.dart';

class CompanyRepository extends BaseRepository {
  final HttpService httpService;
  CompanyRepository(this.httpService) : super(httpService);

  Future<ApiResultModel<PaginationModel>> listCompany(
      CompanyDto companyDto, int actualPage) async {
    var response = await httpService.invokeApi<CompanyDto>(
        method: Method.POST,
        route: ApiRoutes.companyLst,
        data: companyDto,
        header: Header.No,
        parameters: "actualPage=" + actualPage.toString());

    return ApiResultModel<PaginationModel>(
        message: response.message,
        data: PaginationModel(
            totalPages: response.data["totalPages"],
            pagedList: response.data["pagedList"]));
  }

  Future<ApiResultModel<List<CompanyModel>>> listMinifiedCompany(
      CompanyDto companyDto) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.minifiedCompanyLst,
        data: companyDto,
        header: Header.No);

    return ApiResultModel(
        message: response.message,
        data: response.data == null
            ? null
            : CompanyModel.fromJsonList(response.data));
  }

  Future<ApiResultModel<bool>> insertCompany(CompanyDto companyDto) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.companyAdd,
        data: companyDto,
        header: Header.Yes);

    return ApiResultModel<bool>(message: response.message, data: response.data);
  }

  Future<ApiResultModel<PaginationModel>> getCompany(
      CompanyDto companyDto) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.companyLst,
        data: companyDto,
        header: Header.No,
        parameters: "actualPage=" + PageCount.maxPage.toString());

    return ApiResultModel<PaginationModel>(
        message: response.message,
        data: PaginationModel(
            totalPages: response.data["totalPages"],
            pagedList: response.data["pagedList"]));
  }

  Future<ApiResultModel<bool>> updateCompany(CompanyDto companyDto) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.companyEdt,
        data: companyDto,
        header: Header.Yes);

    return ApiResultModel<bool>(message: response.message, data: response.data);
  }

  Future<ApiResultModel<bool>> deleteCompany(CompanyDto companyDto) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.companyDel,
        data: companyDto,
        header: Header.Yes);

    return ApiResultModel<bool>(message: response.message, data: response.data);
  }

  Future<ApiResultModel<PaginationModel>> listApplication(
      ApplicationDto applicationDto, int actualPage) async {
    var response = await httpService.invokeApi<ApplicationDto>(
        method: Method.POST,
        route: ApiRoutes.companyLst,
        data: applicationDto,
        header: Header.No,
        parameters: "actualPage=" + actualPage.toString());

    return ApiResultModel<PaginationModel>(
        message: response.message,
        data: PaginationModel(
            totalPages: response.data["totalPages"],
            pagedList: response.data["pagedList"]));
  }
}
