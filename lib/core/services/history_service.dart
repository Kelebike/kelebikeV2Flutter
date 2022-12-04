

import 'package:cloud_firestore/cloud_firestore.dart';

import 'bike_service.dart';

class HistoryService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference<Map<String, dynamic>>> addHistory(
      String docId) async {
    BikeService bikeService = BikeService();
    String? id = await bikeService.findWithBikeCode(docId);
    bool flag = true;

    _firestore
        .collection("Bike")
        .doc(id)
        .update({
          'return': DateTime.now().toString(),
        })
        .then((_) => print('Updated'))
        .catchError((error) {
          flag = false;
        });

    var ref = _firestore.collection("History");
    var bike = _firestore.collection("Bike").doc(docId);
    var info = await getBikeWithCode(docId);
    
    Map<String, dynamic> _bike = {
      'id': bike.toString(),
      'bike': info,
      'createdAt': FieldValue.serverTimestamp()
    };

    await ref.add(_bike);
    return bike;
  }

  Future<Object?> getBikeWithCode(String code) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("Bike")
        .where('code', isEqualTo: code)
        .get();
    if (query.docs.isNotEmpty) {
      return query.docs[0].data();
    }
    return null;
  }

  Stream<QuerySnapshot> getHistory() {
    var ref = _firestore
        .collection("History")
        .orderBy('createdAt', descending: true)
        .snapshots();

    return ref;
  }

}