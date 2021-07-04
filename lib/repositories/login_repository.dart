import 'package:br_com_mindselfcompany_backoffice_web/constants/api_routes.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/login_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/base_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';

class LoginRepository extends BaseRepository {
  final HttpService httpService;
  LoginRepository(this.httpService) : super(httpService);

  Future<ApiResultModel<LoginModel>> login(LoginModel loginModel) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.login,
        data: loginModel,
        header: Header.No);

    return ApiResultModel(
        message: response.message,
        data:
            response.data == null ? null : LoginModel.fromJson(response.data));
  }

  Future<ApiResultModel<LoginModel>> validateLogin(
      LoginModel loginModel) async {
    var response = await httpService.invokeApi(
        method: Method.POST,
        route: ApiRoutes.login,
        data: loginModel,
        header: Header.Yes);

    return ApiResultModel<LoginModel>(
        message: response.message, data: LoginModel.fromJson(response.data));
  }
}
