class Item {
  final String name;
  final String image;

  Item({
    required this.name,
    required this.image,
  });

  set isCorrect(bool value) {
    isCorrect = value;
  }
}
