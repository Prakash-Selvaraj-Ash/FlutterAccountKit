// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_category_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCategoryResponseDto _$GetCategoryResponseDtoFromJson(
    Map<String, dynamic> json) {
  return GetCategoryResponseDto(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$GetCategoryResponseDtoToJson(
        GetCategoryResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
