class ProductEntity {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int? priceAfterDiscount;
  final int quantity;
  final int sold;
  final String category;
  final String occasion;

  final double rateAvg;
  final int rateCount;

  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    this.priceAfterDiscount,
    required this.quantity,
    required this.sold,
    required this.category,
    required this.occasion,
    required this.rateAvg,
    required this.rateCount,
    required this.createdAt,
    required this.updatedAt,
  });
}