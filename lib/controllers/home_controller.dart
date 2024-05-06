import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt _selectedIndex = 0.obs;
  RxInt get selectedIndex => _selectedIndex;
  set selectedIndex(value) {
    _selectedIndex.value = value;
  }

  var _showNavigationBar = false.obs;
  bool get showNavigationBar => _showNavigationBar.value;
  set showNavigationBar(value) {
    _showNavigationBar.value = value;
  }

  var _extend = false.obs;
  bool get extend => _extend.value;
  set extend(value) {
    _extend.value = value;
  }

  @override
  void onInit() {
    if (Get.arguments == null) {
      _selectedIndex.value = 0;
    } else {
      _selectedIndex.value = Get.arguments["idScreen"];
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
