class Product {
  final int id;
  final String name;
  final String description;
  final double unitPrice;
  final String imageUrl;
  bool isFavorite;

  /// new Product (...id, ...name, ...des, ...unitprice,...)
  /// new Product (name: ....name, des: ...des, id: ...id)
  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.unitPrice,
      required this.imageUrl,
      this.isFavorite = false});
}