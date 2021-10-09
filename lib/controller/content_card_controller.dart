import 'package:get/get.dart';
import 'package:language/model/content_card.dart';
import '../service/firestore/content_card_service.dart';
import 'package:logger/logger.dart';

class CardController extends GetxController {

  static CardController to = Get.find();

  RxList<ContentCard> cards = RxList<ContentCard>();
  RxBool isLoadingCards = false.obs;
  RxBool isAddingCard = false.obs;
  RxBool isLoadingDetails = false.obs;

  final ContentCardService _contentCardService = ContentCardService();
  Logger logger = Logger();

  CardController() {
    cards.bindStream(loadCards());
  }

  Stream<List<ContentCard>> loadCards() {
    return _contentCardService.findAll("tester");
  }
}