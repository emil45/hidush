// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hidush.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hidush _$HidushFromJson(Map<String, dynamic> json) => Hidush(
      id: json['id'] as String,
      source: json['source'] as String,
      sourceDetails: json['sourceDetails'] as String,
      quote: json['quote'] as String,
      peroosh: json['peroosh'] as String,
      rabbi: json['rabbi'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      likes: json['likes'] as int,
      shares: json['shares'] as int,
    );

Map<String, dynamic> _$HidushToJson(Hidush instance) => <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'sourceDetails': instance.sourceDetails,
      'quote': instance.quote,
      'peroosh': instance.peroosh,
      'rabbi': instance.rabbi,
      'categories': instance.categories,
      'likes': instance.likes,
      'shares': instance.shares,
    };
