import 'package:flutter/material.dart';
import 'package:flutteraccountkit/src/category/dto/response/get_category_response_dto.dart';

class CategoryList extends StatelessWidget {
  final List<GetCategoryResponseDto> categories;
  CategoryList(this.categories);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: categories == null ? 0 : categories.length,
        itemBuilder: (BuildContext context, i) {
          return new ListTile(
              title: new Text(categories[i].name),
              subtitle: new Text(categories[i].description));
        });
  }
}
