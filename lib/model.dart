// To parse this JSON data, do
//
//

import 'dart:convert';

List<Dishes> dishesFromJson(String str) =>
    List<Dishes>.from(json.decode(str).map((x) => Dishes.fromJson(x)));
//creating dishes model here
String dishesToJson(List<Dishes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dishes {
  String image;
  String title;
  String price;
  String description;

  Dishes({
    required this.image,
    required this.title,
    required this.price,
    required this.description,
  });

  factory Dishes.fromJson(Map<String, dynamic> json) => Dishes(
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
