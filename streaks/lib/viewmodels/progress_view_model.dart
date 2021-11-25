import 'package:streaks/constants/route_names.dart';
import 'package:streaks/models/goal.dart';
import 'package:streaks/services/dialog_service.dart';
import 'package:streaks/services/firestore_service.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:streaks/viewmodels/base_model.dart';
import 'package:streaks/widgets/goal_item.dart';

import '../locator.dart';

class ProgressViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<Goal> _goals;
  List<Goal> get goals => _goals;

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreateGoalViewRoute);
  }

  Future fetchGoals() async {
    setBusy(true);
    var goalsResults = await _firestoreService.getGoalsOnceOff();
    setBusy(false);

    if (goalsResults is List<Goal>) {
      _goals = goalsResults;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Goals Update Failed',
        description: goalsResults,
      );
    }
  }

  void editPost(int index) {
    _navigationService.navigateTo(CreateGoalViewRoute,
        arguments: _goals[index]);
  }

  void listenToGoals() {
    setBusy(true);

    _firestoreService.listenToGoalsRealTime().listen((goalsData) {
      List<Goal> updatedGoals = goalsData;
      if (updatedGoals != null && updatedGoals.length > 0) {
        _goals = updatedGoals;
        notifyListeners();
      }

      setBusy(false);
    });
  }

  Future deleteGoal(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the post?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deleteGoal(_goals[index].documentId);
      setBusy(false);
    }
  }

  int daysSinceStarting() {
    int count = 1;

    for (int i = 0;
        i < (_goals[i].dateStarted.difference(_goals[i].dateEnding).inDays);
        i++) {
      if (_goals[i].dateStarted.difference(DateTime.now()) >
          Duration(days: 1 + i)) {
        count++;
        print(count);
      }
    }

    return count;
  }

  Future checkGoalCompletion(
      int daysCompleted, int daysMissed, int index) async {
    setBusy(true);
    var goalsResults = await _firestoreService.getGoalsOnceOff();
    setBusy(false);

    if (goalsResults is List<Goal>) {
      _goals = goalsResults;
      notifyListeners();
    }
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Goal Progress',
      description: 'Did you manage to do ${goalsResults[index].title} today?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    var result;

    if (dialogResponse.confirmed) {
      setBusy(true);
      result = await _firestoreService.updateGoal(Goal(
        title: goalsResults[index].title,
        userId: goalsResults[index].userId,
        daysCompleted: 1,
      ));
      setBusy(false);
    } else {
      setBusy(true);
      result = await _firestoreService.updateGoal(Goal(
        title: goalsResults[index].title,
        userId: goalsResults[index].userId,
        daysMissed: 1,
      ));
      setBusy(false);
    }

    return result;
  }
}
