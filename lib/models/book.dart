import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  int id;
  String author;
  String store_name;
  String description;
  String image;
  bool fav;
  String create_at;

  Book({
    required this.id,
    required this.author,
    required this.store_name,
    required this.description,
    required this.image,
    required this.fav,
    required this.create_at,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
