import 'package:br_com_mindselfcompany_backoffice_web/repositories/report_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class ReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportRepository>(
        () => ReportRepository(Get.find<HttpService>()),
        fenix: true);
  }
}
