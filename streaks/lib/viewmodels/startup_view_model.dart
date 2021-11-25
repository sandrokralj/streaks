import 'package:streaks/constants/route_names.dart';
import 'package:streaks/locator.dart';
import 'package:streaks/services/authentication_service.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:streaks/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(SigninViewRoute);
    }
  }
}
