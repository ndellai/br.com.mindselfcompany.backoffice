import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class CompanyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyRepository>(
        () => CompanyRepository(Get.find<HttpService>()),
        fenix: true);
  }
}
