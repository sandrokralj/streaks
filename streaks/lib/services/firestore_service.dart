import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streaks/models/friends.dart';
import 'package:streaks/models/goal.dart';
import 'package:streaks/models/strkuser.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference _goalsCollectionReference =
      FirebaseFirestore.instance.collection('goals');

  final document = FirebaseFirestore.instance.collection('goals').snapshots();

  final StreamController<List<Goal>> _goalController =
      StreamController<List<Goal>>.broadcast();

  final StreamController<List<String>> _friendsController =
      StreamController<List<String>>.broadcast();

  Stream listenFriends() {
//  DocumentSnapshot document = task.getResult();
// List<String> friendList = (List<String>) document.get("friendList");
    var firebaseUser = FirebaseAuth.instance.currentUser;
    _usersCollectionReference
        .doc(firebaseUser.uid)
        .snapshots()
        .listen((friendsSnapshot) {
      if (friendsSnapshot.data().isNotEmpty) {
        var friends = friendsSnapshot.get("friendList");
        // Add the posts onto the controller
        List<String> friendsList = new List<String>.from(friends);
        _friendsController.add(friendsList);
      }
    });

    return _friendsController.stream;
  }

  Future getFriendsOnceOff() async {
    try {
      var firebaseUser = await FirebaseAuth.instance.currentUser;
      var userDocuments = await _usersCollectionReference.get();
      var userID = _usersCollectionReference.doc(firebaseUser.uid);
      var friends = await _usersCollectionReference
          .doc(userID.toString())
          .get()
          .then((querySnapshot) {
        querySnapshot.get('friendList');
      });
      return friends.docs.toList();
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
    }
  }

  // try {
  //   final Stream<DocumentSnapshot> friendsDocStream = FirebaseFirestore
  //       .instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser.uid.toString())
  //       .snapshots();
  // var friends = await _usersCollectionReference.doc(uid).get().then((querySnapshot){
  //   querySnapshot.get('friendList');
  //       });
  // return friends.docs
  //    .toList();
  // return StreamBuilder<DocumentSnapshot>(
  //     stream: friendsDocStream,
  //     builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.active) {
  //         // get course document
  //         var userDoc = snapshot.data.data;

  //         // get sections from the document
  //         var friends = userDoc()['friendList'];

  //         // build list using names from sections
  //         return ListView.builder(
  //           itemCount: friends != null ? friends.length : 0,
  //           itemBuilder: (_, int index) {
  //             print(friends.key);
  //             return ListTile(title: Text(friends.key));
  //           },
  //         );
  //       } else {
  //         return Container();
  //       }
  //     });
  // } catch (e) {
  //   if (e is PlatformException) {
  //     return e.message;
  //   }

  //   return e.toString();
  // }
  Future addFriend(String friendID) async {
    try {
      var firebaseUser = await FirebaseAuth.instance.currentUser;
      var userID = _usersCollectionReference.doc(firebaseUser.uid);
      await FirebaseFirestore.instance
          .collection('users')
          .doc('$userID')
          .update({
        'friendList': FieldValue.arrayUnion([friendID])
      });
      // var listfromDB;
      // listfromDB = await _usersCollectionReference
      //     .doc(userID.toString())
      //     .get()
      //     .then((querySnapshot) {
      //   querySnapshot.get('friendList');
      // });
      // List<dynamic> emptyList = List.from(listfromDB);
      // emptyList.add(friendID);
      // await _usersCollectionReference
      //     .doc(userID.toString())
      //     .update({'friendList': emptyList});
      // listfromDB.listfromDB =
      //     await _usersCollectionReference.doc(userID.toString()).update({
      //   'friendList': FieldValue.arrayUnion([friendID])
      // });
    } catch (e) {
      return e.toString();
    }
  }

  Future addGoal(Goal goal) async {
    try {
      await _goalsCollectionReference.add(goal.toMap());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future getGoalsOnceOff() async {
    try {
      var firebaseUser = await FirebaseAuth.instance.currentUser;
      var goalDocuments = await _goalsCollectionReference.get();
      var userID = _usersCollectionReference.doc(firebaseUser.uid);
      if (goalDocuments.docs.isNotEmpty) {
        return goalDocuments.docs
            .map((snapshot) => Goal.fromMap(
                  snapshot.data(),
                  snapshot.id,
                ))
            .where((mappedItem) =>
                mappedItem.title != null &&
                mappedItem.userId == firebaseUser.uid)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future deleteGoal(String documentId) async {
    await _goalsCollectionReference.doc(documentId).delete();
  }

  Future updateGoal(Goal goal) async {
    try {
      await _goalsCollectionReference.doc(goal.documentId).update(goal.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future createUser(StrkUser user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.message;
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

  String formatTimestamp(Timestamp timestamp) {
    var format = DateFormat('y-MM-d');
    return format.format(timestamp.toDate());
  }

  DateTime convertToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  Stream listenToGoalsRealTime() {
    // Register the handler for when the goals data changes

    var firebaseUser = FirebaseAuth.instance.currentUser;
    _goalsCollectionReference.snapshots().listen((goalsSnapshot) {
      if (goalsSnapshot.docs.isNotEmpty) {
        var goals = goalsSnapshot.docs
            .map((snapshot) {
              //convertToDateTime(snapshot.data()['dateStarted']);
              return Goal.fromMap(
                snapshot.data(),
                snapshot.id,
              );
            })
            .where((mappedItem) =>
                mappedItem.title != null &&
                mappedItem.userId == firebaseUser.uid)
            .toList();

        // Add the goals onto the controller
        _goalController.add(goals);
      }
    });

    return _goalController.stream;
  }
}
