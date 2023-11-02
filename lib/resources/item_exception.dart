enum ItemType {
  libro, libreria
}

class ItemPresentException implements Exception {
  ItemType itemType;
  String msg;
  ItemPresentException(this.itemType, this.msg);

  @override
  String toString() => msg;
}


class ItemNotPresentException implements Exception {
  ItemType itemType;
  String msg;
  ItemNotPresentException(this.itemType, this.msg);

  @override
  String toString() => msg;
}