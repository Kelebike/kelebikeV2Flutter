import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kelebikev2/core/models/blacklist_model.dart';

class BlacklistService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String mediaUrl = '';


  Future<ModelBlacklist?> addBlackList({
    required String user,
    required String reason,
  }) async {
    var ref = _firestore.collection("Blacklist");
    if (await isDuplicateUniqueName(user)) {
      return null;
    } else {
      var documentRef = await ref.add({
        'user': user,
        'reason': reason,
      });

      return ModelBlacklist(id: documentRef.id, email: user, reason: reason);
    }
  }

  Stream<QuerySnapshot> getBlackList() {
    var ref = _firestore.collection("Blacklist").snapshots();
    return ref;
  }

  Future<void> removeBlackList(String docId) {
    var ref = _firestore.collection("Blacklist").doc(docId).delete();

    return ref;
  }

  Future<bool> isDuplicateUniqueName(String uniqueName) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("Blacklist")
        .where('email', isEqualTo: uniqueName)
        .get();
    return query.docs.isNotEmpty;
  }

  Future<String?> findWithEmail(String email) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("Blacklist")
        .where('email', isEqualTo: email)
        .get();
    if (query.docs.isEmpty) return null;
    return query.docs.first.id;
  }


}