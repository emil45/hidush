import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hidush.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable()
class Hidush {
  final String id, source, sourceDetails, quote, peroosh, rabbi;
  final List<String> categories;
  int likes, shares;
  @TimestampConverter()
  final DateTime lastUpdate;

  Hidush({
    required this.id,
    required this.source,
    required this.sourceDetails,
    required this.quote,
    required this.peroosh,
    required this.rabbi,
    required this.lastUpdate,
    required this.categories,
    required this.likes,
    required this.shares,
  });

  factory Hidush.fromJson(Map<String, dynamic> json) => _$HidushFromJson(json);

  Map<String, dynamic> toJson() => _$HidushToJson(this);
}
