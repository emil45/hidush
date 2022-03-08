import 'package:json_annotation/json_annotation.dart';

part 'hidush.g.dart';

@JsonSerializable()
class Hidush {
  String source, sourceDetails, quota, peerosh, rabbi;
  List<String> labels;
  int likes, shares;

  Hidush({
    required this.source,
    required this.sourceDetails,
    required this.quota,
    required this.peerosh,
    required this.rabbi,
    required this.labels,
    required this.likes,
    required this.shares,
  });

  factory Hidush.fromJson(Map<String, dynamic> json) => _$HidushFromJson(json);

  Map<String, dynamic> toJson() => _$HidushToJson(this);
}
