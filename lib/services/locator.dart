import 'package:appointment_management/services/local_storage_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future<void> initializeLocator() async {
  locator.registerSingleton(LocalStorageService());
}
