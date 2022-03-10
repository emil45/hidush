// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'],
      uid: json['uid'],
      likedHidushim: (json['likedHidushim'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sharedHidushim: Map<String, int>.from(json['sharedHidushim'] as Map),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'likedHidushim': instance.likedHidushim,
      'sharedHidushim': instance.sharedHidushim,
    };
