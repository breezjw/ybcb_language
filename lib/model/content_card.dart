import 'package:cloud_firestore/cloud_firestore.dart';

class ContentCard {
  String? id;
  String? title;
  String? uid;
  String? text;
  bool done;

  ContentCard({this.id, this.uid, this.title, this.text, this.done = false});
  copyWith({title, done}) {
    return ContentCard(
      id: id,
      title: title ?? this.title,
      text: text ?? this.text,
      uid: uid ?? this.uid,
      done: done ?? this.done
    );
  }

  factory ContentCard.fromSnapshot(DocumentSnapshot snap) {
    return ContentCard(
        id: snap.id,
        done: snap.get("done"),
        title: snap.get("title"),
        text: snap.get("text")
    );
  }

  toJson() {
    return {"title": title, "done": done};
  }
}