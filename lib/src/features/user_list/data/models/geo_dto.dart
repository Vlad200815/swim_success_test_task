import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/entities.dart';

part "geo_dto.g.dart";

@JsonSerializable()
class GeoDto {
  final String? lat;
  final String? lng;

  const GeoDto({required this.lat, required this.lng});

  /// Deserializer...
  factory GeoDto.fromJson(Map<String, dynamic> json) => _$GeoDtoFromJson(json);

  /// Serializer...
  Map<String, dynamic> toJson() => _$GeoDtoToJson(this);

  GeoEntity toEntity() => GeoEntity(lat: lat, lng: lng);
}
