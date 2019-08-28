import 'package:flutteraccountkit/src/web_request/iresponse.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_category_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class GetCategoryResponseDto implements IResponse<GetCategoryResponseDto> {
  GetCategoryResponseDto({this.id, this.name, this.description});

  String id;
  String name;
  String description;

  factory GetCategoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetCategoryResponseDtoFromJson(json);

  @override
  GetCategoryResponseDto toObject(Map<String, dynamic> responseJson) {
    return GetCategoryResponseDto.fromJson(responseJson);
  }
}
