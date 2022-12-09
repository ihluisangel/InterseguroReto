class User {
  User({
    required this.name,
  });

  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
