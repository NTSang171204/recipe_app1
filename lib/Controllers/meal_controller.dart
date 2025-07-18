import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/recipe_card_model.dart';

class MealController {
  static Future<List<Meal>> fetchByArea(String area) async {
    final uri = Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?a=$area');
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final meals = (data['meals'] as List)
          .map((e) => Meal.fromJson(e))
          .toList();
          return meals;
    } else {
      throw Exception('Failed to load meals from area, Error: ${res.statusCode}');
    }
  }
}

//Category meal controller:
class CategoryMealController {
  static Future<List<Meal>> fetchByCategory(String category) async {
    final uri = Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      return (data['meals'] as List)
        .map((e) => Meal.fromJson(e))
        .toList();
    } else {
      throw Exception('Error fetching meals: ${resp.statusCode}');
    }
  }
}

//Search meal controller:

class MealApi {
  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return (data['meals'] as List).map((meal) => Meal.fromJson(meal)).toList();
      }
      return [];
    } else {
      throw Exception('Failed to load meals');
    }
  }
}


class SearchMealController {
  final _meals = <Meal>[];
  List<Meal> get meals => _meals;

  Future<void> searchMeals(String query) async {
    try {
      _meals.clear();
      if (query.isNotEmpty) {
        _meals.addAll(await MealApi.searchMeals(query));
      }
    } catch (e) {
      throw Exception('Error searching meals: $e');
    }
  }


}