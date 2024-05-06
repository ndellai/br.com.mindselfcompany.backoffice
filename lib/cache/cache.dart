import 'package:get_storage/get_storage.dart';

import '../flavors/setup.dart';

class Cache {
  static Future<void> set<T>(String key, T? value) async =>
      await GetStorage("storage_${Setup.appFlavor.toString()}")
          .write(key, value);

  static T? get<T>(String key) =>
      GetStorage("storage_${Setup.appFlavor.toString()}").read<T>(key);
}
