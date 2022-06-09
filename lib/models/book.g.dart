// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as int,
      author: json['author'] as String,
      store_name: json['store_name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      fav: json['fav'] as bool,
      create_at: json['create_at'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'store_name': instance.store_name,
      'description': instance.description,
      'image': instance.image,
      'fav': instance.fav,
      'create_at': instance.create_at,
    };
