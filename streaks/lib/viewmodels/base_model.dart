import 'package:flutter/widgets.dart';
import 'package:streaks/models/strkuser.dart';
import 'package:streaks/services/authentication_service.dart';

import '../locator.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  StrkUser get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
