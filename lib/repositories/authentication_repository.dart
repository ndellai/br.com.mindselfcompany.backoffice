import 'package:br_com_mindselfcompany_backoffice_web/constants/api_routes.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/pagination_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/base_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';

import '../dto/authentication_dto.dart';

class AuthenticationRepository extends BaseRepository {
  final HttpService httpService;
  AuthenticationRepository(this.httpService) : super(httpService);

  Future<ApiResultModel<PaginationModel>> listAuthentication(
      AuthenticationDto authenticationDto, int actualPage) async {
    var response = await httpService.invokeApi<AuthenticationDto>(
        method: Method.POST,
        route: ApiRoutes.authenticationLst,
        data: authenticationDto,
        header: Header.No,
        parameters: "actualPage=" + actualPage.toString());

    return ApiResultModel<PaginationModel>(
        message: response.message,
        data: PaginationModel(
            totalPages: response.data["totalPages"],
            pagedList: response.data["pagedList"]));
  }
}
