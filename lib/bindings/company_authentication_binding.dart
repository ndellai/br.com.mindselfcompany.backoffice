import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';
import 'package:get/get.dart';

import '../controllers/company_application_authentication_controller.dart';
import '../repositories/application_repository.dart';
import '../repositories/authentication_repository.dart';
import '../repositories/company_application_authentication_repository.dart';

class CompanyAuthenticationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyRepository>(
        () => CompanyRepository(Get.find<HttpService>()));

    Get.lazyPut<ApplicationRepository>(
        () => ApplicationRepository(Get.find<HttpService>()));

    Get.lazyPut<AuthenticationRepository>(
        () => AuthenticationRepository(Get.find<HttpService>()));

    Get.lazyPut<CompanyApplicationAuthenticationRepository>(() =>
        CompanyApplicationAuthenticationRepository(Get.find<HttpService>()));

    Get.lazyPut<CompanyApplicationAuthenticationController>(() =>
        CompanyApplicationAuthenticationController(
            Get.find<CompanyRepository>(),
            Get.find<ApplicationRepository>(),
            Get.find<AuthenticationRepository>(),
            Get.find<CompanyApplicationAuthenticationRepository>()));
  }
}
