import 'package:json_annotation/json_annotation.dart';

part 'temp_book.g.dart';

@JsonSerializable()
class TempBook {
  String author;
  String store_name;
  String description;
  bool fav;

  TempBook({
    required this.author,
    required this.store_name,
    required this.description,
    required this.fav,
  });
  factory TempBook.fromJson(Map<String, dynamic> json) => _$TempBookFromJson(json);
  Map<String, dynamic> toJson() => _$TempBookToJson(this);
}
