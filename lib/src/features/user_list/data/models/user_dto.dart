import 'package:json_annotation/json_annotation.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/entities/entities.dart';

import 'address_dto.dart';
import 'company_dto.dart';

part "user_dto.g.dart";

@JsonSerializable(explicitToJson: true)
class UserDto {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final AddressDto? address;
  final String? phone;
  final String? website;
  final CompanyDto? company;

  const UserDto({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  /// Deserializer...
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Serializer...
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toEntity() => UserEntity(
    id: id,
    name: name,
    username: username,
    email: email,
    address: address?.toEntity(),
    phone: phone,
    website: website,
    company: company?.toEntity(),
  );
}
