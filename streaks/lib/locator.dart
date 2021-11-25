import 'package:streaks/services/authentication_service.dart';
import 'package:get_it/get_it.dart';
import 'package:streaks/services/firestore_service.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:streaks/services/dialog_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}
