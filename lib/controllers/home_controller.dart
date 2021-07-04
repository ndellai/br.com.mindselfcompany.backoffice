import 'package:get/get.dart';

class HomeController extends GetxController {
  var _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(value) {
    _selectedIndex.value = value;
    update(["home"]);
  }

  var _showNavigationBar = false.obs;
  bool get showNavigationBar => _showNavigationBar.value;
  set showNavigationBar(value) {
    _showNavigationBar.value = value;
    update(["home"]);
  }

  var _extend = false.obs;
  bool get extend => _extend.value;
  set extend(value) {
    _extend.value = value;
    update(["home"]);
  }
}
