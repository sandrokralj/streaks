import 'package:streaks/constants/route_names.dart';
import 'package:streaks/models/strkuser.dart';
import 'package:streaks/services/authentication_service.dart';
import 'package:streaks/services/dialog_service.dart';
import 'package:streaks/services/firestore_service.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:streaks/viewmodels/base_model.dart';

import '../locator.dart';

class FriendListViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  var _friends;
  get friends => _friends;
  Future navigateToCreateView() async {
    await _navigationService.navigateTo(FriendListViewRoute);
  }

  StrkUser get currentUser => _authenticationService.currentUser;

  Future getFriends() async {
    setBusy(true);
    var _friendsRes = await _firestoreService.getFriendsOnceOff();
    setBusy(false);
    _friends = _friendsRes;
    notifyListeners();
  }

  void showFriend(int index) {
    _navigationService.navigateTo(FriendListViewRoute,
        arguments: _friends[index]);
  }
  
  void listenToFriends() {
    setBusy(true);

    _firestoreService.listenFriends().listen((frList) {
      var updatedList = frList;
      if (updatedList != null && updatedList.length > 0) {
        _friends = updatedList;
        notifyListeners();
      }

      setBusy(false);
    });
  }

  Future removeFriend(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to remove this person?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      //delete friend
      setBusy(false);
    }
  }
}
