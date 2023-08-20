import 'package:hive/hive.dart';

class HiveStorageService {
  save({
    required String key,
    required dynamic value,
    required String boxKey,
  }) async {
    final box = await Hive.openBox(boxKey);
    await box.put(key, value);
  }

  Future<dynamic> fetch({
    required String key,
    required String boxKey,
  }) async {
    final box = await Hive.openBox(boxKey);
    final data = await box.get(key);

    return data;
  }

  Future<dynamic> clear({
    required String boxKey,
  }) async {
    final box = await Hive.openBox(boxKey);

    box.clear();
  }
}
