import 'package:br_com_mindselfcompany_backoffice_web/controllers/company_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';
import 'package:get/get.dart';

class CompanyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyRepository>(
        () => CompanyRepository(Get.find<HttpService>()));

    Get.lazyPut<CompanyController>(
        () => CompanyController(Get.find<CompanyRepository>()));
  }
}
