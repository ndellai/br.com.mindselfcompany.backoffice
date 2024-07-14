import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/login_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/login_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  @protected
  final LoginRepository loginRepository;

  LoginController(this.loginRepository);

  final _isLoading = false.obs;
  final _isLogged = false.obs;

  RxBool _isObscureText = true.obs;

  RxBool get isLoading => _isLoading;
  bool get isLogged => _isLogged.value;

  bool get isObscureText => _isObscureText.value;
  set isObscureText(bool value) => _isObscureText.value = value;

  TextEditingController logemail = TextEditingController();
  TextEditingController logsenha = TextEditingController();

  @override
  void onInit() {
    if (kDebugMode) {
      logemail.text = "adm@mindself.com.br";
      logsenha.text = "54321";
    }

    super.onInit();
  }

  @override
  void onClose() {
    logemail.dispose();
    logsenha.dispose();
    super.onClose();
  }

  Future sendValues() async {
    // LoginModel userModel = LoginModel(
    //   email: logemail.text,
    //   password: logsenha.text,
    // );

    // var result = await _loginController.login(userModel);

    // if (!result.data) {
    //   print(result.message);
    //   return;
    // }
    //
    //

    if ((logemail.text.trim().toLowerCase() != "adm@mindself.com.br") ||
        (logsenha.text.trim() != "54321")) {
      Get.snackbar(
        "ATENÇÃO!",
        "Login inválido!",
        colorText: Colors.white,
        backgroundColor: Colors.black,
        boxShadows: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(3, 3),
            blurRadius: 3,
          )
        ],
      );
    } else
      Get.offAndToNamed("/home");
  }

  Future<ApiResultModel<bool>> login(LoginModel loginModel) async {
    _isLoading.value = true;

    ApiResultModel<LoginModel> _loginModel =
        await loginRepository.login(loginModel);

    _isLoading.value = false;

    if (_loginModel.message!.isEmpty) {
      if (_loginModel.data!.token!.isNotEmpty) {
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

    if (result.message!.isEmpty) {
      _isLogged.value = true;
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }
}
