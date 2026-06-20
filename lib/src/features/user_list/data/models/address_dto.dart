import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/entities.dart';
import 'geo_dto.dart';

part "address_dto.g.dart";

@JsonSerializable(explicitToJson: true)
class AddressDto {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final GeoDto? geo;

  const AddressDto({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  /// Deserializer...
  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  /// Serializer...
  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  AddressEntity toEntity() => AddressEntity(
    street: street,
    suite: suite,
    city: city,
    zipcode: zipcode,
    geo: geo?.toEntity(),
  );
}
