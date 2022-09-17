import '../model/shopping.dart';

class DataHelper {
  static List<Shopping> allShoppingList = [];

  static addShoppingList(Shopping shopping) {
    allShoppingList.add(shopping);
  }

  static total() {
    double totalMoney = 0;
    for (var element in allShoppingList) {
      totalMoney =
          totalMoney + (element.productNumber) * (element.productPrice);
    }
    return totalMoney;
  }
}
