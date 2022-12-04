import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;

@jsonSerializable
class ModelBike {
  String? id;
  String? brand;
  String? code;
  String? lock;
  String? owner;
  Bool? status;

  ModelBike({this.id, this.brand, this.code, this.owner, this.lock, this.status});

  factory ModelBike.fromSnapshot(DocumentSnapshot snapshot) {
    return ModelBike(
        id: snapshot.id,
        lock: snapshot["serial_number"],
        brand: snapshot["brand"],
        code: snapshot["code"],
        status: snapshot["status"],
        owner: snapshot["owner"]);
  }
}
