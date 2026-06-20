import 'package:json_annotation/json_annotation.dart';

part 'pace_seconds_dto.g.dart';

@JsonSerializable()
class PaceSecondsDto {
  /// paceSeconds
  @JsonKey(name: "pace_seconds")
  final int paceSeconds;

  PaceSecondsDto({required this.paceSeconds});

  /// Deserializer...
  factory PaceSecondsDto.fromJson(Map<String, dynamic> json) =>
      _$PaceSecondsDtoFromJson(json);

  /// Serializer...
  Map<String, dynamic> toJson() => _$PaceSecondsDtoToJson(this);
}
