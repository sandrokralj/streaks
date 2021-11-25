import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:streaks/models/strkuser.dart';
import 'package:streaks/services/dialog_service.dart';
import 'package:streaks/services/firestore_service.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:streaks/viewmodels/base_model.dart';

import '../locator.dart';

class AccountViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  StrkUser _user;
  StrkUser get user => _user;

  getCurrentUser() async {
    var userName = await _usersCollectionReference.get();
    for (var user in userName.docs) {
      user.data();
    }
  }

  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _user = await _firestoreService.getUser(user.uid);
    }
  }

  Future<String> getUsername() async {
    var currentUserName = await _firebaseAuth.currentUser.displayName;
    if (currentUserName != null)
      return currentUserName;
    else {
      return null;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return StrkUser.fromData(userData.data());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
