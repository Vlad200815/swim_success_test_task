// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  username: json['username'] as String?,
  email: json['email'] as String?,
  address: json['address'] == null
      ? null
      : AddressDto.fromJson(json['address'] as Map<String, dynamic>),
  phone: json['phone'] as String?,
  website: json['website'] as String?,
  company: json['company'] == null
      ? null
      : CompanyDto.fromJson(json['company'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'email': instance.email,
  'address': instance.address?.toJson(),
  'phone': instance.phone,
  'website': instance.website,
  'company': instance.company?.toJson(),
};
