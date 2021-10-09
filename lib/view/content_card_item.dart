import 'package:flutter/material.dart';
import 'package:language/model/content_card.dart';

class CardItem extends StatelessWidget {
  final ContentCard contentCard;

  const CardItem(this.contentCard, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: contentCard.done ? Colors.grey : Colors.green[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text(
                  "Title: ${contentCard.title}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ]),
            ),
            Text(
              contentCard.done ? "Finished" : "Ready",
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${contentCard.text}"),
            ),
          ]
        ),
      )
    );
  }
}