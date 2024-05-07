import 'package:hive/hive.dart';

class LocalStorageService {
  late Box _box;
  LocalStorageService() {
    _initializeBox();
  }

  Future<void> _initializeBox() async {
    _box = await Hive.openBox('bookingApp');
  }

  Future<void> clearAll() async {
    await _box.clear();
  }

  Future<void> saveData({required String key, required dynamic value}) async {
    await _box.put(key, value);
  }

  dynamic getData({required String key}) {
    return _box.get(key);
  }
}
