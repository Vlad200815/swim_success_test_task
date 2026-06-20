import 'package:equatable/equatable.dart';

import 'geo_entity.dart';

class AddressEntity extends Equatable {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final GeoEntity? geo;

  const AddressEntity({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  @override
  List<Object?> get props => [street, suite, city, zipcode, geo];
}
