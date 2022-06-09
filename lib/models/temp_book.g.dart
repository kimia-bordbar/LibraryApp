// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TempBook _$TempBookFromJson(Map<String, dynamic> json) => TempBook(
      author: json['author'] as String,
      store_name: json['store_name'] as String,
      description: json['description'] as String,
      fav: json['fav'] as bool,
    );

Map<String, dynamic> _$TempBookToJson(TempBook instance) => <String, dynamic>{
      'author': instance.author,
      'store_name': instance.store_name,
      'description': instance.description,
      'fav': instance.fav,
    };
