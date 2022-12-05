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
  String? status;
  String? dateIssued;
  String? dateReturn;

  ModelBike({
    required this.id,
    required this.lock,
    required this.brand,
    required this.code,
    required this.status,
    required this.dateIssued,
    required this.dateReturn,
    required this.owner,
  });

  factory ModelBike.fromSnapshot(DocumentSnapshot snapshot) {
    return ModelBike(
        id: snapshot.id,
        lock: snapshot["serial_number"],
        brand: snapshot["brand"],
        code: snapshot["code"],
        status: snapshot["status"],
        dateIssued: snapshot["issued"],
        dateReturn: snapshot["return"],
        owner: snapshot["owner"]);
  }
}
