import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Goal {
  final String title;
  final String userId;
  final String documentId;
  final int numberOfDays;
  final int daysCompleted;
  final int daysMissed;
  final DateTime dateStarted;
  final DateTime dateEnding;

  Goal({
    @required this.userId,
    @required this.title,
    this.numberOfDays,
    this.documentId,
    this.dateStarted,
    this.dateEnding,
    this.daysCompleted = 0,
    this.daysMissed = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'numberOfDays': numberOfDays,
      'dateStarted': dateStarted,
      'dateEnding': dateEnding,
      'daysCompleted': daysCompleted,
      'daysMissed': daysMissed,
    };
  }

  static Goal fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Goal(
      title: map['title'],
      userId: map['userId'],
      numberOfDays: map['numberOfDays'],
      documentId: documentId,
      dateStarted: (map['dateStarted'] as Timestamp)?.toDate(),
      dateEnding: (map['dateEnding'] as Timestamp)?.toDate(),
      daysCompleted: map['daysCompleted'],
      daysMissed: map['daysMissed'],
    );
  }
}
