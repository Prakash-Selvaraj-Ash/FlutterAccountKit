import 'package:flutteraccountkit/src/category/dto/response/get_category_response_dto.dart';
import 'package:flutteraccountkit/src/shared/web_client_service_base.dart';
import 'package:flutteraccountkit/src/web_request/http_method.dart';
import 'package:flutteraccountkit/src/web_request/web_request_builder.dart';

class CategoryServiceClient extends WebClientServiceBase {
  Future<List<GetCategoryResponseDto>> getCategories() async {
    WebRequestBuilder requestBuilder = WebRequestBuilder()
    .create(HttpMethod.Get, '$baseUrl/api/categories');

    var response = await requestBuilder.executeRequestAsync();
    List<dynamic> categories = response;
    return categories.map((cat) => GetCategoryResponseDto.fromJson(cat)).toList();
  }
}