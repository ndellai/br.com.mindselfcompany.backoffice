import 'package:br_com_mindselfcompany_backoffice_web/constants/api_routes.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/pagination_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/base_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';

import '../dto/company_application_authentication_dto.dart';

class CompanyApplicationAuthenticationRepository extends BaseRepository {
  final HttpService httpService;
  CompanyApplicationAuthenticationRepository(this.httpService)
      : super(httpService);

  Future<ApiResultModel<PaginationModel>> listCompanyApplicationAuthentication(
      CompanyApplicationAuthenticationDto companyApplicationAuthenticationDto,
      int actualPage) async {
    var response =
        await httpService.invokeApi<CompanyApplicationAuthenticationDto>(
            method: Method.POST,
            route: ApiRoutes.companyApplicationAuthenticationLst,
            data: companyApplicationAuthenticationDto,
            header: Header.No,
            parameters: "actualPage=" + actualPage.toString());

    return ApiResultModel<PaginationModel>(
        message: response.message,
        data: PaginationModel(
            totalPages: response.data["totalPages"],
            pagedList: response.data["pagedList"]));
  }

  Future<ApiResultModel<bool>> updateCompanyApplicationAuthentication(
      List<CompanyApplicationAuthenticationDto>
          companyApplicationAuthenticationDto) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.companyApplicationAuthenticationEdt,
        data:
            companyApplicationAuthenticationDto.map((e) => e.toJson()).toList(),
        header: Header.No);

    return ApiResultModel<bool>(message: response.message, data: response.data);
  }
}
