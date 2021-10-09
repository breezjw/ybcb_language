
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language/model/content_card.dart';
import 'package:language/service/firestore/models.dart';

class ContentCardService {
  CollectionReference contentCardsRef = FirebaseFirestore.instance.collection(FireStoreContentCard.collection);

  Stream<List<ContentCard>> findAll(userId) {
    return contentCardsRef
      .where(FireStoreContentCard.uid, isEqualTo: userId)
      .snapshots()
      .map(
        (qShot) => qShot.docs.map((doc) {
          return ContentCard.fromSnapshot(doc);
      }).toList());
  }
}