import 'package:br_com_mindselfcompany_backoffice_web/flavors/setup.dart';
import 'package:br_com_mindselfcompany_backoffice_web/modules/app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Setup.appFlavor = FlavorType.PRD;

  await GetStorage.init("storage_PRD");

  setPathUrlStrategy();
  runApp(App());
}
