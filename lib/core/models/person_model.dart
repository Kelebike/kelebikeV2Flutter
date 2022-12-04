import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;

@jsonSerializable
class ModelPerson {
  String? id;
  String? email;
  String? label;
  Bool? status;

  ModelPerson({this.id, this.email, this.label, this.status});

  factory ModelPerson.fromSnapshot(DocumentSnapshot snapshot) {
    return ModelPerson(
        id: snapshot.id,
        email: snapshot["email"],
        label: snapshot["label"],
        status: snapshot["status"]);
  }
}
