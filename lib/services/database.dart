import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/models/weight.dart';

class DatabaseService {
  final CollectionReference weightCollection =
      FirebaseFirestore.instance.collection('weight');

  // updating weight
  Future<void> uploadWeight({double unit, DateTime updated}) async {
    DocumentReference documentReference = weightCollection.doc();
    String docId = documentReference.id;
    return await documentReference
        .set({'uid': docId, 'unit': unit, 'updated': updated});
  }

  // edit weight entry
  Future<void> editWeight({double unit, String uid}) async {
    DocumentReference documentReference = weightCollection.doc(uid);
    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      return transaction.update(documentReference, {'unit': unit});
    });
  }

  // delete weight entry
  Future<void> deleteWeight({String uid}) async {
    return await weightCollection.doc(uid).delete();
  }

  // map the snapshots to weight model
  List<Weight> _weightDataFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      return Weight(
          uid: snapshot.get('uid'),
          unit: snapshot.get('unit'),
          updated: snapshot.get('updated').toDate());
    }).toList();
  }

  // getting weights stream
  Stream<List<Weight>> get weights {
    return weightCollection
        .orderBy('updated', descending: true)
        .snapshots()
        .map(_weightDataFromSnapshot);
  }
}
