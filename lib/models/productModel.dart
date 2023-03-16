class ProductModel {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  bool? isFavourite;

  ProductModel(
      {this.id,
      required this.category,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite});
}
