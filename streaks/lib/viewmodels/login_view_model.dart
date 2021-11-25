import 'package:streaks/constants/route_names.dart';
import 'package:streaks/locator.dart';
import 'package:streaks/services/authentication_service.dart';
import 'package:streaks/services/dialog_service.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future resetPw({@required String email}) async {
    setBusy(true);
    var result = _authenticationService.resetPassword(email);
    setBusy(false);
    if (result != null) {
      await _dialogService.showDialog(
        title: 'E-mail for password reset was successfully sent!',
        description:
            'Please check your e-mail and follow the instructions for password reset.',
      );
    } else {
      await _dialogService.showDialog(
        title: 'E-mail sending failure.',
        description: 'General failure. Please try again later',
      );
    }
  }

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }
}
