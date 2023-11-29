class Product {
  String id;

  String name;

  String url;

  int price;

  int stockQuantity;

  Product(
      {required this.id,
      required this.name,
      required this.url,
      required this.price,
      required this.stockQuantity});



  factory Product.fromJson(Map<String, dynamic> json) {
    var id = json['id'] ?? "";
    var name = json['name'] ?? "item";
    var url = json['url'] ?? "";
    var price = json['price'] ?? "0";
    var stockQuantity = json['stock_quantity'] ?? 0;

    return Product(
        id: id,
        name: name,
        url: url,
        price: price,
        stockQuantity: stockQuantity);
  }
}
