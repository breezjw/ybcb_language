
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language/controller/content_card_controller.dart';
import 'package:logger/logger.dart';

import 'content_card_item.dart';

class ContentCardList extends StatelessWidget {
  ContentCardList({Key? key}) : super(key: key);

  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    CardController cardController = Get.put<CardController>(CardController());

    return Scaffold(
      appBar: AppBar(
        title: Text("YBCB Language"),
      ),
      body: Obx(() {
        if (cardController.isLoadingCards.value) {
          return Container(child: Center(child: CircularProgressIndicator()));
        }

        if (cardController.cards.length == 0) {
          return Center(child: Text('Nothing to do'));
        }

        logger.d(cardController.cards[0].title);

        return ListView.builder(
          itemCount: cardController.cards.length,
          itemBuilder: (context, index) {
            return CardItem(cardController.cards.elementAt(index));
          });
      }),
    );
  }
}