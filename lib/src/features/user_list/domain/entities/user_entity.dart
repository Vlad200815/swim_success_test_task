import 'package:equatable/equatable.dart';

import 'address_entity.dart';
import 'company_entity.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final AddressEntity? address;
  final String? phone;
  final String? website;
  final CompanyEntity? company;

  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    username,
    email,
    address,
    phone,
    website,
    company,
  ];
}
