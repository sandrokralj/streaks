import 'package:streaks/services/authentication_service.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:streaks/viewmodels/base_model.dart';

import '../locator.dart';

class HomePageViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void signOut() {
    _authenticationService.signOut();
    _navigationService.pop();
  }
}
