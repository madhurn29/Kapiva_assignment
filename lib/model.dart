// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  String image;
  String title;
  String price;
  String description;

  Welcome({
    required this.image,
    required this.title,
    required this.price,
    required this.description,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        image: json["image"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "price": price,
        "description": description,
      };
}
