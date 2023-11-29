class Seller {
  String id;

  String name;

  String url;

  Seller({
    required this.id,
    required this.name,
    required this.url,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    var id = json['id'] ?? "";
    var name = json['name'] ?? "item";
    var url = json['url'] ?? "";

    return Seller(
      id: id,
      name: name,
      url: url,
    );
  }
}
