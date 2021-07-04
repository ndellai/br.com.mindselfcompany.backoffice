import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/login_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class LoginController extends GetxController {
  @protected
  final LoginRepository loginRepository;

  LoginController(this.loginRepository);

  final _isLoading = false.obs;
  final _isLogged = false.obs;

  var _isObscureText = true.obs;

  bool get isLoading => _isLoading.value;
  bool get isLogged => _isLogged.value;

  get isObscureText => _isObscureText.value;
  set isObscureText(bool value) => _isObscureText.value = value;

  Future<ApiResultModel<bool>> login(LoginModel loginModel) async {
    _isLoading.value = true;

    ApiResultModel<LoginModel> _loginModel =
        await loginRepository.login(loginModel);

    _isLoading.value = false;

    if (_loginModel.message.isEmpty) {
      if (_loginModel.data.token.isNotEmpty) {
        _isLogged.value = true;
      }
      return ApiResultModel<bool>(data: true);
    } else
      return ApiResultModel<bool>(message: _loginModel.message, data: false);
  }

  Future<ApiResultModel<bool>> validateLogin(LoginModel loginModel) async {
    _isLoading.value = true;

    ApiResultModel<LoginModel> result =
        await loginRepository.validateLogin(loginModel);

    _isLoading.value = false;

    if (result.message.isEmpty) {
      _isLogged.value = true;
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }
}
