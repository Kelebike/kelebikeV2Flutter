import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;

@jsonSerializable
class ModelBlacklist {
  String? id;
  String? email;
  String? reason;

  ModelBlacklist({this.id, this.email, this.reason});

  factory ModelBlacklist.fromSnapshot(DocumentSnapshot snapshot) {
    return ModelBlacklist(
        id: snapshot.id,
        email: snapshot["email"],
        reason: snapshot["reason"]);
  }
}