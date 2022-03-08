// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hidush.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hidush _$HidushFromJson(Map<String, dynamic> json) => Hidush(
      source: json['source'] as String,
      sourceDetails: json['sourceDetails'] as String,
      quota: json['quota'] as String,
      peerosh: json['peerosh'] as String,
      rabbi: json['rabbi'] as String,
      labels:
          (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
      likes: json['likes'] as int,
      shares: json['shares'] as int,
    );

Map<String, dynamic> _$HidushToJson(Hidush instance) => <String, dynamic>{
      'source': instance.source,
      'sourceDetails': instance.sourceDetails,
      'quota': instance.quota,
      'peerosh': instance.peerosh,
      'rabbi': instance.rabbi,
      'labels': instance.labels,
      'likes': instance.likes,
      'shares': instance.shares,
    };
