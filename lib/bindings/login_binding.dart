import 'package:br_com_mindselfcompany_backoffice_web/repositories/login_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpService>(() => HttpService(), fenix: true);
    Get.lazyPut<LoginRepository>(() => LoginRepository(Get.find<HttpService>()),
        fenix: true);
  }
}
