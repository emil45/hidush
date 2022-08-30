// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbuser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DBUser _$DBUserFromJson(Map<String, dynamic> json) => DBUser(
      email: json['email'],
      uid: json['uid'],
      likedHidushim: (json['likedHidushim'] as List<dynamic>).map((e) => e as String).toList(),
      sharedHidushim: Map<String, int>.from(json['sharedHidushim'] as Map),
    );

Map<String, dynamic> _$DBUserToJson(DBUser instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'likedHidushim': instance.likedHidushim,
      'sharedHidushim': instance.sharedHidushim,
    };
