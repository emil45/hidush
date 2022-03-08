import 'package:json_annotation/json_annotation.dart';

part 'hidush.g.dart';

@JsonSerializable()
class Hidush {
  String id, source, sourceDetails, quote, peroosh, rabbi;
  List<String> categories;
  int likes, shares;

  Hidush({
    required this.id,
    required this.source,
    required this.sourceDetails,
    required this.quote,
    required this.peroosh,
    required this.rabbi,
    required this.categories,
    required this.likes,
    required this.shares,
  });

  factory Hidush.fromJson(Map<String, dynamic> json) => _$HidushFromJson(json);

  Map<String, dynamic> toJson() => _$HidushToJson(this);
}
