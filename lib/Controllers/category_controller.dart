import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoryController {
  static Future<List<Categories>> fetchCategories() async {
    final uri = Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      final List categoriesJson = data['categories'];
      return categoriesJson.map((e) => Categories.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}
