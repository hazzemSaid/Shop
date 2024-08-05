class Product {
  final int id;
  final String title;
  final int price;
  final String description;
  final List<String> images;
  final String category;
  final int category_id;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
    required this.category_id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      images: List<String>.from(json['images']),
      category: json['category']['name'],
      category_id: json['category']['id'],
    );
  }
}
