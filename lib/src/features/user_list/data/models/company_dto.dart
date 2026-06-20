import 'package:json_annotation/json_annotation.dart';
import 'package:swim_success_test_task/src/features/user_list/domain/entities/company_entity.dart';

part "company_dto.g.dart";

@JsonSerializable()
class CompanyDto {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  const CompanyDto({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  /// Deserializer...
  factory CompanyDto.fromJson(Map<String, dynamic> json) =>
      _$CompanyDtoFromJson(json);

  /// Serializer...
  Map<String, dynamic> toJson() => _$CompanyDtoToJson(this);

  CompanyEntity toEntity() =>
      CompanyEntity(name: name, catchPhrase: catchPhrase, bs: bs);
}
