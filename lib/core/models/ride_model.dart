import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;

@jsonSerializable
class ModelRide {
  String? id;
  String? code;
  String? email;
  String? startDate;
  String? finishDate;

  ModelRide({this.id, this.code, this.email, this.startDate ,this.finishDate });

  factory ModelRide.fromSnapshot(DocumentSnapshot snapshot) {
    return ModelRide(
        id: snapshot.id,
        code: snapshot["code"],
        email: snapshot["email"],
        startDate: snapshot["startDate"],
        finishDate: snapshot["finishDate"]);
  }
}
