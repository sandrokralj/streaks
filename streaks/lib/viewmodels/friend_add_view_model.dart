import 'package:flutter/foundation.dart';
import 'package:streaks/services/dialog_service.dart';
import 'package:streaks/services/firestore_service.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:streaks/viewmodels/base_model.dart';
import '../locator.dart';
import 'package:streaks/constants/route_names.dart';
import 'package:streaks/models/strkuser.dart';
import 'package:streaks/services/authentication_service.dart';

class FriendAddViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(FriendAddViewRoute);
  }

  StrkUser get currentUser => _authenticationService.currentUser;

  Future addFriend({@required String friendUID}) async {
    setBusy(true);
    var result;
    result = await _firestoreService.addFriend(friendUID);

    setBusy(false);
    if (result != null) {
      await _dialogService.showDialog(
        title: 'User successfully added!',
        description: 'New user added to your friend list!',
      );
    }
    else{
       await _dialogService.showDialog(
        title: 'Oops',
        description: 'Something went wrong',
      );
    }

   
  }
}
