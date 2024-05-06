import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/employee_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/upload_file_service.dart';
import 'package:get/get.dart';

import '../controllers/employee_controller.dart';

class EmployeeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadFileService>(() => UploadFileService());

    Get.lazyPut<EmployeeRepository>(() => EmployeeRepository(
        Get.find<HttpService>(), Get.find<UploadFileService>()));

    Get.lazyPut<EmployeeController>(() => EmployeeController(
        Get.find<EmployeeRepository>(), Get.find<CompanyRepository>()));
  }
}
