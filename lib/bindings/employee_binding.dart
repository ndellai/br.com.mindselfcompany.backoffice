import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/employee_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/upload_file_service.dart';

class EmployeeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadFileService>(() => UploadFileService(), fenix: true);
    Get.lazyPut<EmployeeRepository>(
        () => EmployeeRepository(
            Get.find<HttpService>(), Get.find<UploadFileService>()),
        fenix: true);
    Get.lazyPut<CompanyRepository>(
        () => CompanyRepository(
              Get.find<HttpService>(),
            ),
        fenix: true);
  }
}
