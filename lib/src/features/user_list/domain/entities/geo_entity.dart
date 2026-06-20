import 'package:equatable/equatable.dart';

class GeoEntity extends Equatable {
  final String? lat;
  final String? lng;

  const GeoEntity({required this.lat, required this.lng});

  @override
  List<Object?> get props => [lat, lng];
}
