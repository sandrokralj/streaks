import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:streaks/models/goal.dart';
import 'package:streaks/services/dialog_service.dart';
import 'package:streaks/services/firestore_service.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:streaks/viewmodels/base_model.dart';
import '../locator.dart';

class CreateGoalViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Goal _edittingGoal;

  bool get _editting => _edittingGoal != null;

  void setEdittingGoal(Goal goal) {
    _edittingGoal = goal;
  }

  Future addGoal(
      {@required String title,
      @required int numberOfDays,
      @required DateTime dateStarted,
      @required DateTime dateEnded}) async {
    setBusy(true);

    var result;

    if (!_editting) {
      result = await _firestoreService.addGoal(Goal(
        title: title,
        numberOfDays: numberOfDays,
        userId: currentUser.id,
        dateStarted: dateStarted,
        dateEnding: dateEnded,
      ));
    } else {
      result = await _firestoreService.updateGoal(Goal(
        title: title,
        numberOfDays: numberOfDays,
        userId: _edittingGoal.userId,
        documentId: _edittingGoal.documentId,
        dateStarted: dateStarted,
        dateEnding: dateEnded,
      ));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not create goal.',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Goal successfully added!',
        description: 'Your goal has been created!',
      );
    }

    _navigationService.pop();
  }
}
