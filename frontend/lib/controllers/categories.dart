import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_sathi/models/category_model.dart';

class CategoriesController {
  static Future<bool> postCategory(String name) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/categories/'),
        body: json.encode({
          'name': name,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
   static Future<List<CategoryModel>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/categories/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

}
