class Profile {
  String id = "";

  String name;

  String email;

  String mobile;

  String url;

  Profile(
      {required this.id,
      required this.name,
      required this.email,
      required this.mobile,
      required this.url});

  factory Profile.fromJson(Map<String, dynamic> json) {
    var id = json['id'] ?? "";
    var name = json['name'] ?? "User";
    var url = json['url'] ?? "";
    var mobile = json['mobile'] ?? "";
    var email = json['email'] ?? "";

    return Profile(id: id, name: name, url: url, mobile: mobile, email: email);
  }
}
