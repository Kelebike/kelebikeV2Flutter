import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;

@jsonSerializable
class ModelHistory {
  String? id;
  String? dateReturn;
  String? dateTaken;
  String? email;
  Bool? status;

  ModelHistory({this.id, this.dateReturn, this.dateTaken, this.email, this.status});

  factory ModelHistory.fromSnapshot(DocumentSnapshot snapshot) {
    return ModelHistory(
        id: snapshot.id,
        dateReturn: snapshot["dateReturn"],
        dateTaken: snapshot["dateTaken"],
        email: snapshot["email"],
        status: snapshot["status"]);
  }
}
